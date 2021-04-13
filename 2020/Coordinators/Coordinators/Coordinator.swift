//
//  Coordinator.swift
//  Coordinators
//
//  Created by 이재용 on 2021/03/24.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
