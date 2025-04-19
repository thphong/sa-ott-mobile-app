//
//  ProfileViewController.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 09/01/2024.
//

import UIKit

final class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let avatarImageView = UIImageView()
    private let fullNameField = PaddingTextField(padding: 16)
    private let phoneField = PaddingTextField(padding: 16)
    private let statusField = PaddingTextField(padding: 16)
    private let activeSwitch = UISwitch()
    private let btnSave = UIButton(type: .system)
    
    private var userData: UserModel?
    private var pickedAvatarImage: UIImage? = nil
    private var currentAvatarURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .iceBlue
        setupViews()
        fetchUserInfo()
    }
    
    private func setupViews() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.backgroundColor = .gray
        avatarImageView.image = UIImage(systemName: "person.circle.fill")
        avatarImageView.tintColor = .white
        avatarImageView.isUserInteractionEnabled = false
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeAvatar)))

        // Labels
        let lblFullName = UILabel()
        lblFullName.text = "Fullname"
        lblFullName.font = .interMedium(16)

        let lblPhone = UILabel()
        lblPhone.text = "Phone number"
        lblPhone.font = .interMedium(16)

        let lblStatus = UILabel()
        lblStatus.text = "Status"
        lblStatus.font = .interMedium(16)
        
        fullNameField.delegate = self
        phoneField.delegate = self
        statusField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        // TextFields
        [fullNameField, phoneField, statusField].forEach {
            $0.borderStyle = .roundedRect
            $0.backgroundColor = .white
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let activeLabel = UILabel()
        activeLabel.text = "Is active"
        activeLabel.font = .interMedium(16)
        
        activeSwitch.isEnabled = false

        let activeStack = UIStackView(arrangedSubviews: [activeLabel, activeSwitch])
        activeStack.axis = .horizontal
        activeStack.spacing = 12
        activeStack.alignment = .center

        let saveTitle = "Save"
        let saveAttrs = [NSAttributedString.Key.font: UIFont.interMedium(18), NSAttributedString.Key.foregroundColor: UIColor.white]
        let saveString = NSMutableAttributedString(string: saveTitle, attributes: saveAttrs)

        btnSave.setAttributedTitle(saveString, for: .normal)
        btnSave.backgroundColor = .brightRoyalBlue
        btnSave.layer.cornerRadius = 10
        btnSave.translatesAutoresizingMaskIntoConstraints = false
        btnSave.addTarget(self, action: #selector(saveInfo), for: .touchUpInside)

        // Group each label + field into vertical stacks
        let fullNameStack = UIStackView(arrangedSubviews: [lblFullName, fullNameField])
        fullNameStack.axis = .vertical
        fullNameStack.spacing = 8

        let phoneStack = UIStackView(arrangedSubviews: [lblPhone, phoneField])
        phoneStack.axis = .vertical
        phoneStack.spacing = 8

        let statusStack = UIStackView(arrangedSubviews: [lblStatus, statusField])
        statusStack.axis = .vertical
        statusStack.spacing = 8

        // Combine everything into the main vertical stack
        let mainStack = UIStackView(arrangedSubviews: [fullNameStack, phoneStack, statusStack, activeStack, btnSave])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(avatarImageView)
        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 200),
            avatarImageView.heightAnchor.constraint(equalToConstant: 200),

            mainStack.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            fullNameField.heightAnchor.constraint(equalToConstant: 48),
            phoneField.heightAnchor.constraint(equalToConstant: 48),
            statusField.heightAnchor.constraint(equalToConstant: 48),
            btnSave.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func fetchUserInfo() {
        UserService.shared.getCurrentInfo { success, userData in
            if success {
                self.userData = userData
                self.fullNameField.text = userData?.name
                self.phoneField.text = userData?.phone
                self.statusField.text = userData?.status
                self.activeSwitch.isOn = userData?.isOnline ?? true
                self.currentAvatarURL = userData?.avatar
                ChatSocketManager.shared.getPublicFile(key: userData?.avatar ?? "") { success, publicURL in
                    if success, let publicKey = publicURL {
                        self.avatarImageView.kf.setImage(with: publicKey)
                    }
                }
            }
        }
    }

    @objc private func changeAvatar() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            avatarImageView.image = pickedImage
            pickedAvatarImage = pickedImage
        }
        dismiss(animated: true)
    }

    @objc private func saveInfo() {
        var avatarPath: String? = nil

        // If user picked a new image, save it temporarily and get path
        if let pickedImage = pickedAvatarImage,
           let imageData = pickedImage.jpegData(compressionQuality: 0.8) {
            let fileName = UUID().uuidString + ".jpg"
            let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

            do {
                try imageData.write(to: fileURL)
                avatarPath = fileURL.path
            } catch {
                print("❌ Failed to write image: \(error)")
            }
        }

        // Now call your updateInfo with avatar path
        UserService.shared.updateInfo(name: fullNameField.text, avatarURL: currentAvatarURL) { success in
            if success {
                // AuthenManager.updateAuthModel(name: self.fullNameField.text, avatar: avatarPath)

                let alert = UIAlertController(title: "Saved", message: "Your information has been updated.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                })
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Failed", message: "Update failed. Please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
            return true
    }
}
