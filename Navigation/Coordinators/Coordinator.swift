//
//  Coordinator.swift
//  Navigation
//
//  Created by Виталий Мишин on 27.11.2023.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var controller: UIViewController { get set }
    func setup()
    
}
