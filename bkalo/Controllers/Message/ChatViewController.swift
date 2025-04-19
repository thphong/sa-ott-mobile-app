//
//  ChatViewController.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 21/2/25.
//

import UIKit
import MessageKit
import InputBarAccessoryView

final class ChatViewController: MessagesViewController {
    private var socketManager: ChatSocketManager?
    private var messages: [MessageKit.MessageType] = []
    private var chatSender: ChatMember = {
        guard let auth = AuthenManager.getSavedAuthModel() else {
            fatalError("No authenticated user found")
        }
        return ChatMember(
            senderId: "\(auth.id)",
            displayName: auth.name,
            avatarURL: auth.avatar
        )
    }()
    
    private var isGroupChat: Bool = false
    private var chatPartner: ChatPartner?
    private var groupChat: GroupChat?
    private var privateChatId: Int = 0
        
    init(chatPartner: ChatPartner) {
        self.chatPartner = chatPartner
        self.isGroupChat = false
        super.init(nibName: nil, bundle: nil)
    }
    
    init(groupChat: GroupChat) {
        self.groupChat = groupChat
        self.isGroupChat = true
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        maintainPositionOnInputBarHeightChanged = true
        
        messagesCollectionView.backgroundColor = UIColor.ghostWhite
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        messagesCollectionView.addGestureRecognizer(tapGesture)
        
        configureMessageInputBar()
        
        socketManager = ChatSocketManager.shared
        
        guard let auth = AuthenManager.getSavedAuthModel() else { return }
        if let url = URL(string: "wss://api.sa-ott-zalo.click/ws/users/\(auth.id)") {
            socketManager?.createSocket(url: url)
        }
        
        fetchChatHistory()
        
        socketManager?.onReceiveMessage = { [weak self] message in
            guard let self = self else { return }
            self.messages.append(message)
            DispatchQueue.main.async {
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToLastItem(animated: true)
            }
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    private func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.tintColor = UIColor(hexString: "#439BF0")
        messageInputBar.sendButton.setTitleColor(UIColor(hexString: "#439BF0"), for: .normal)
        messageInputBar.sendButton.setTitleColor(UIColor(hexString: "#439BF0")!.withAlphaComponent(0.3), for: .highlighted)
    }
    
    private func setupNavigationBar() {
        let titleView = ChatTitleView()
        if isGroupChat, let group = groupChat {
            titleView.configure(name: group.name, isOnline: false, lastSeen: nil)
        } else if let partner = chatPartner {
            titleView.configure(name: partner.name, isOnline: partner.isOnline, lastSeen: partner.lastSeen)
        }
        navigationItem.titleView = titleView

        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton

        let infoButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(infoButtonTapped))
        navigationItem.rightBarButtonItem = infoButton
    }
    
    private func fetchChatHistory() {
        if let group = groupChat {
            ChatSocketManager.shared.getChatHistory(groupId: group.id) { success, results in
                DispatchQueue.main.async {
                    if success {
                        self.messages = results ?? []
                    } else {
                        self.messages = []
                    }
                    
                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToLastItem(animated: true)
                }
            }
        }
        if let partner = chatPartner {
            ChatSocketManager.shared.getGroupPrivate(friendId: partner.id) { success, result in
                if success {
                    guard let id = result else { return }
                    self.privateChatId = id
                    ChatSocketManager.shared.getChatHistory(groupId: self.privateChatId) { success, results in
                        DispatchQueue.main.async {
                            if success {
                                self.messages = (results ?? []).sorted(by: { $0.sentDate < $1.sentDate })
                            } else {
                                self.messages = []
                            }
                            
                            self.messagesCollectionView.reloadData()
                            self.messagesCollectionView.scrollToLastItem(animated: true)
                        }
                    }
                }
            }
        }
    }
            
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func infoButtonTapped() {
        // Handle info button tap
        print("Info button tapped")
    }
    
    @objc private func dismissKeyboard() {
        messageInputBar.inputTextView.resignFirstResponder()
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if messagesCollectionView.numberOfSections == 0 { return }
        DispatchQueue.main.async {
            let section = self.messagesCollectionView.numberOfSections - 1
            let item = self.messagesCollectionView.numberOfItems(inSection: section) - 1
            if item >= 0 {
                let indexPath = IndexPath(item: item, section: section)
                self.messagesCollectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
}

extension ChatViewController: MessagesDataSource {
    var currentSender: any SenderType { return chatSender }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> any MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
}

extension ChatViewController: MessagesDisplayDelegate {
    func messageStyle(for message: any MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        return isFromCurrentSender(message: message) ? .bubbleTail(.bottomRight, .curved) : .bubbleTail(.bottomLeft, .curved)
    }
    
    func backgroundColor(for message: any MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor.lightCyanBlue : UIColor.nearWhite
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: any MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let group = DispatchGroup()
        var updatedMembers: [ChatPartner] = []
        
        if isFromCurrentSender(message: message) {
            avatarView.image = UIImage(systemName: "house")
            return
        }
        
        if isGroupChat {
            guard let groupChat = groupChat else {
                avatarView.image = UIImage(systemName: "person.crop.circle")
                return
            }
            
            for var member in groupChat.members {
                group.enter()
                ChatSocketManager.shared.getPublicFile(key: member.avatarURL ?? "") { success, publicURL in
                    if success, let publicKey = publicURL {
                        member.fullAvatarURL = publicKey
                    } else {
                        print("No public key for user \(member.id)")
                    }
                    updatedMembers.append(member)
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                if let matchingMember = updatedMembers.first(where: { "\($0.id)" == message.sender.senderId }),
                   let avatarURL = matchingMember.fullAvatarURL {
                    avatarView.kf.setImage(with: avatarURL)
                } else {
                    avatarView.image = UIImage(systemName: "person.crop.circle")
                }
            }
        } else {
            guard var chatPartner = chatPartner else {
                avatarView.image = UIImage(systemName: "person.crop.circle")
                return
            }
            
            group.enter()
            ChatSocketManager.shared.getPublicFile(key: chatPartner.avatarURL ?? "") { success, publicURL in
                if success, let publicKey = publicURL {
                    chatPartner.fullAvatarURL = publicKey
                } else {
                    print("No public key for user \(chatPartner.id)")
                }
                group.leave()
            }
            
            group.notify(queue: .main) {
                if let avatarURL = chatPartner.fullAvatarURL {
                    avatarView.kf.setImage(with: avatarURL)
                } else {
                    avatarView.image = UIImage(systemName: "person.crop.circle")
                }
            }
        }
    }
    
    func textColor(for message: any MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return .black
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.darkGray
        ])
    }

    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let dateString = DateFormatter.localizedString(from: message.sentDate, dateStyle: .none, timeStyle: .short)
        return NSAttributedString(string: dateString, attributes: [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.lightGray
        ])
    }

    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let date = message.sentDate
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: date)

        return NSAttributedString(string: dateString, attributes: [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor.gray
        ])
    }
}

extension ChatViewController: MessageCellDelegate {
    func didTapAvatar(in _: MessageCollectionViewCell) {
        print("Avatar tapped")
    }

    func didTapMessage(in _: MessageCollectionViewCell) {
        print("Message tapped")
    }

    func didTapImage(in _: MessageCollectionViewCell) {
        print("Image tapped")
    }

    func didTapCellTopLabel(in _: MessageCollectionViewCell) {
        print("Top cell label tapped")
    }

    func didTapCellBottomLabel(in _: MessageCollectionViewCell) {
        print("Bottom cell label tapped")
    }

    func didTapMessageTopLabel(in _: MessageCollectionViewCell) {
        print("Top message label tapped")
    }

    func didTapMessageBottomLabel(in _: MessageCollectionViewCell) {
        print("Bottom label tapped")
    }

    func didStartAudio(in _: AudioMessageCell) {
        print("Did start playing audio sound")
    }

    func didPauseAudio(in _: AudioMessageCell) {
        print("Did pause audio sound")
    }

    func didStopAudio(in _: AudioMessageCell) {
        print("Did stop audio sound")
    }

    func didTapAccessoryView(in _: MessageCollectionViewCell) {
        print("Accessory view tapped")
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }

        let newMessage = Message(
            sender: chatSender,
            messageId: UUID().uuidString,
            sentDate: Date(),
            kind: .text(trimmedText)
        )

        messages.append(newMessage)
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToLastItem(animated: true)

        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let messageDict: [String: Any] = [
            "message": trimmedText,
            "group_id": groupChat?.id ?? privateChatId,
            "message_type": "text",
            "time": isoFormatter.string(from: Date()),
            "is_group": isGroupChat,
            "person": chatSender.toDictionary()
        ]

//        if let data = try? JSONSerialization.data(withJSONObject: messageDict, options: []) {
//            print("📤 Sending message JSON: \(data)")
//            socketManager?.sendMessage(data: data)
//        }
        
        if JSONSerialization.isValidJSONObject(messageDict) {
            do {
                let data = try JSONSerialization.data(withJSONObject: messageDict, options: [])
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("📤 JSON string sent: \(jsonString)")
                    socketManager?.sendMessage(data: data)
                }
            } catch {
                print("❌ Error serializing JSON: \(error.localizedDescription)")
            }
        }

        inputBar.inputTextView.text = ""
    }
}


extension ChatViewController: MessagesLayoutDelegate {
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0 // You can adjust this if you later support location messages
    }

    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: messagesCollectionView.bounds.width, height: 16)
    }

    func heightForCellTopLabel(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }

    func heightForMessageTopLabel(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }

    func heightForMessageBottomLabel(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }
}
