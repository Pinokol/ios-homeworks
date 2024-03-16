//
//  ExtensionUIView.swift
//  Navigation
//
//  Created by Виталий Мишин on 24.08.2023.
//
import UIKit

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.addSubview(i)
        }
    }
}
