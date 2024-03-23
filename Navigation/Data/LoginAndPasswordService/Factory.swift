//
//  Factory.swift
//  Navigation
//
//  Created by Виталий Мишин on 27.11.2023.
//

import UIKit

protocol FactoryProtocol {
    func makeLoginInspector() -> LoginInspector
}

class MainFactory: FactoryProtocol {
    
    private let inspector = LoginInspector()
    
    func makeLoginInspector() -> LoginInspector {
        return inspector
    }
    
}
