//
//  Extension.swift
//  FileManager
//
//  Created by Виталий Мишин on 26.02.2024.
//

import UIKit

extension String {
    static let sortingFile = "Sorting file"
    static let sizeFile = "Size file"
}

struct Settings {
    static var sortingFile = true
    static var sizeFile = true
    private init(){}
}

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.addSubview(i)
        }
    }
}


extension CGFloat {
    static let spacing16: CGFloat = 16
    static let spacing20: CGFloat = 20
}
