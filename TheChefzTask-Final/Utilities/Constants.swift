//
//  Constants.swift
//  TheChefzTask
//
//  Created by Noor Walid on 29/07/2022.
//

import Foundation

struct Constants {
    //MARK: General Constants
    static let baseURL = "https://www.googleapis.com/books/v1"
    static let dummyURL = URL(string: "")!
    static let defaultImage = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png"
    static let defaultMaxNumber = 20
        
    //MARK: UI Components Constants
    struct StoryBoards {
        static let MainStoryboard = "Main"
        static let SearchStoryboard = "Search"
        static let BookDetailsStoryboard = "BookDetails"
    }
    
    struct ViewControllers {
        static let MainViewController = "MainViewController"
        static let SearchViewController = "SearchViewController"
        static let BookDetailsViewController = "BookDetailsViewController"
    }
    
    struct CollectionViewCells {
        static let BookCollectionViewCellID = "BookCollectionViewCell"
    }
    
    struct XIBs {
        static let BookCollectionViewCellXIB = "BookCollectionViewCell"
    }
}
