//
//  Utils.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 22/3/25.
//

import UIKit

final class Utils {
    static func showDialogMessage(navigateBack: Bool = false) {
        guard let contentWindow = SceneDelegate.sharedInstance?.window else {
            print("Error: SceneDelegate.shared is nil!")
            return
        }

        let contentCustom = NotificationDialogView()
        contentCustom.frame = contentWindow.bounds
        contentWindow.addSubview(contentCustom)

        contentCustom.transform = CGAffineTransform(translationX: 0, y: contentWindow.bounds.height)

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut) {
            contentCustom.transform = .identity
        }
        
        contentCustom.onDismiss = {
            if navigateBack {
                DispatchQueue.main.async {
                    if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
                        navigationController.popToRootViewController(animated: true)

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            if let welcomeVC = navigationController.viewControllers.first as? WelcomeViewController {
                                welcomeVC.autoPressLoginButton()
                            }
                        }
                    }
                }
            }
        }
    }
}
