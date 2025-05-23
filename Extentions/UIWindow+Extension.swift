//
//  UIWindow+Extensions.swift
//  Wordle
//
//  Created by mri on 19/4/2025.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
                return nil
        }
        return window
    }
}
