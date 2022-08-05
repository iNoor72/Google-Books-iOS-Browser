//
//  MainScreenNavigationRoutes.swift
//  TheChefzTask
//
//  Created by Noor Walid on 31/07/2022.
//

import UIKit

enum MainScreenNavigationRoutes: Route {
    case SearchScreen
    case DetailsScreen(Book)
    
    var destination: UIViewController {
        switch self {
        case .DetailsScreen(let book):
            guard let detailsViewController = UIStoryboard(name: Constants.StoryBoards.BookDetailsStoryboard, bundle: nil).instantiateViewController(withIdentifier: Constants.ViewControllers.BookDetailsViewController) as? BookDetailsViewController else { return UIViewController() }
            detailsViewController.detailsViewModel = BookDetailsViewModel(book: book)
            
            return detailsViewController
            
        case .SearchScreen:
            guard let searchViewController = UIStoryboard(name: Constants.StoryBoards.SearchStoryboard, bundle: nil)
                .instantiateViewController(withIdentifier: Constants.ViewControllers.SearchViewController) as? SearchViewController else { return UIViewController() }
            
            return searchViewController
            
        }
    }
    
    var style: NavigationStyle {
        switch self {
        case .SearchScreen:
            return .push
        case .DetailsScreen(_):
            return .push
        }
    }
    
}
