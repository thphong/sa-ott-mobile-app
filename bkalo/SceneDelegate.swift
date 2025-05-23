//
//  SceneDelegate.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 08/01/2024.
//

import UIKit
import FirebaseAuth

private var messageViewController: MessageViewController = {
    let tabBarItem = UITabBarItem()
    tabBarItem.title = "Tin nhắn"
    tabBarItem.image = UIImage(systemName: "ellipsis.message")
    tabBarItem.selectedImage = UIImage(systemName: "ellipsis.message.fill")
    
    let viewController = MessageViewController()
    viewController.tabBarItem = tabBarItem
    return viewController
}()

private var contactViewController: ContactViewController = {
    let tabBarItem = UITabBarItem()
    tabBarItem.title = "Contact"
    tabBarItem.image = UIImage(systemName: "person.crop.square")
    tabBarItem.selectedImage = UIImage(systemName: "person.crop.square.fill")
    
    let viewController = ContactViewController()
    viewController.tabBarItem = tabBarItem
    return viewController
}()

private var accountViewController: AccountViewController = {
    let tabBarItem = UITabBarItem()
    tabBarItem.title = "User"
    tabBarItem.image = UIImage(systemName: "person")
    tabBarItem.selectedImage = UIImage(systemName: "person.fill")
    
    let viewController = AccountViewController()
    viewController.tabBarItem = tabBarItem
    return viewController
}()

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var isLoggedIn: Bool = false

    static var sharedInstance: SceneDelegate? {
        return UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }).flatMap({ $0.delegate as? SceneDelegate })
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        UIBarButtonItem.appearance().tintColor = .white
        
        isLoggedIn = !(Auth.auth().currentUser == nil)
        
        if isLoggedIn {
            window.rootViewController = createMainTabBarController()
        } else {
            window.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
        }
        
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected Tab : \(tabBarController.selectedIndex)")
    }
}

extension SceneDelegate {
    func setRootLoginVC() {
        self.window?.clearAllRootVC()
        self.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        self.window?.makeKeyAndVisible()
    }
    
    func switchToMainTabBar() {
        guard let window = self.window else { return }
        
        isLoggedIn = true
        window.rootViewController = createMainTabBarController()
        window.makeKeyAndVisible()
    }

    private func createMainTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.delegate = self
        tabBarController.viewControllers = [
            // NavigationController(rootViewController: messageViewController),
            NavigationController(rootViewController: contactViewController),
            NavigationController(rootViewController: accountViewController)
        ]
        tabBarController.tabBar.tintColor = .dodgerBlue
        tabBarController.view.backgroundColor = .clear
        tabBarController.tabBar.backgroundColor = .nearWhite
        
        return tabBarController
    }
}
