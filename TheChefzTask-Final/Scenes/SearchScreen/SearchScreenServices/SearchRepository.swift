//
//  SearchRepository.swift
//  TheChefzTask-Final
//
//  Created by Noor Walid on 06/08/2022.
//

import Foundation

class SearchRepository {
    private let cache: DatabaseProtocol
    private let network: NetworkServiceProtocol
    
    init(cache: DatabaseProtocol, network: NetworkServiceProtocol) {
        self.cache = cache
        self.network = network
    }
    
    func deleteLastSearchResultFromDatabase() {
        cache.deleteAll()
    }
    
    func deleteLastSearchKeywordFromDatabase() {
        cache.deleteLastKeyword()
    }
    
    func saveLastSearchToDatabase(keyword: String) {
        cache.saveLastSearch(keyword: keyword)
    }
    
    func saveSearchResultToDatabase(book: Book) {
        cache.save(book: book)
    }
    
    func fetchBooksFromNetwork(bookName: String, page: Int, onFetch: (@escaping (Result<BooksResponse, Error>) -> Void)) {
        network.fetchData(url: .books(bookName: bookName, page: page), expectedType: BooksResponse.self)
        { result in
            switch result {
            case .failure(let error):
                onFetch(.failure(error))
            case .success(let response):
                onFetch(.success(response))
            }
        }
    }
    
}
