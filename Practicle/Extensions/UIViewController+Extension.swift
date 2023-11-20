//
//  UIViewController+Extension.swift
//  Practicle
//
//  Created by Pratima on 16/11/23.
//

import UIKit


extension UIViewController {
    func showMessage(_ message: String?) {
        let alert = UIAlertController(title: nil, message: message ?? "Unknown Error", preferredStyle: .actionSheet)
        self.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                alert.dismiss(animated: true)
            })
        }
    }
}
