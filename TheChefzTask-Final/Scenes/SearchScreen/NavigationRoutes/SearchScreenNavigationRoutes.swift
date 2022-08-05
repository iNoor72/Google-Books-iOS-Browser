//
//  SearchScreenNavigationRoutes.swift
//  TheChefzTask
//
//  Created by Noor Walid on 01/08/2022.
//

import UIKit

enum SearchScreenNavigationRoutes: Route {
case DetailsScreen(Book)
    
    var destination: UIViewController {
        switch self {
        case .DetailsScreen(let book):
            guard let detailsViewController = UIStoryboard(name: Constants.StoryBoards.BookDetailsStoryboard, bundle: nil).instantiateViewController(withIdentifier: Constants.ViewControllers.BookDetailsViewController) as? BookDetailsViewController else { return UIViewController() }
            detailsViewController.detailsViewModel = BookDetailsViewModel(book: book)
            
            return detailsViewController
        }
    }
    
    var style: NavigationStyle {
        switch self {
        case .DetailsScreen(_):
            return .push
        }
    }
}
