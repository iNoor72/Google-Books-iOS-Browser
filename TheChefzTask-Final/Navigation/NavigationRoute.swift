//
//  NavigationRoute.swift
//  TheChefzTask
//
//  Created by Noor Walid on 31/07/2022.
//

import Foundation
import UIKit

protocol NavigationRoute {
    func navigate(to route: Route)
}

//Applied and can be used from any ViewController
extension UIViewController: NavigationRoute {
    func navigate(to route: Route) {
        switch route.style {
        case .modal:
            self.present(route.destination, animated: true, completion: nil)
        case .push:
            self.navigationController?.pushViewController(route.destination, animated: true)
        }
    }
}
