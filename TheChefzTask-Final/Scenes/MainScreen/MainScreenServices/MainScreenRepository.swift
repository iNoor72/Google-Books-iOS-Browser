//
//  BooksRepository.swift
//  TheChefzTask-Final
//
//  Created by Noor Walid on 06/08/2022.
//

import Foundation

class MainScreenRepository {
    private let cache: DatabaseProtocol
    private let network: NetworkServiceProtocol
    
    init(cache: DatabaseProtocol, network: NetworkServiceProtocol) {
        self.cache = cache
        self.network = network
    }
    
    func fetchDataFromDatabase(onFetch: (@escaping ([Book]) -> Void)) {
        cache.fetch { books in
            onFetch(books)
        }
    }
    
    func fetchLastSearchKeyword() -> String? {
        let keyword = cache.fetchLastSearch()
        return keyword?.first?.bookTitle
    }
}
