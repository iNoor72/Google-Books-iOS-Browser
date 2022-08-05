//
//  Route.swift
//  TheChefzTask
//
//  Created by Noor Walid on 31/07/2022.
//

import Foundation
import UIKit

protocol Route {
    var destination: UIViewController { get }
    var style: NavigationStyle { get }
}

enum NavigationStyle {
    case modal
    case push
}
