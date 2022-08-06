//
//  MockRealmManager.swift
//  TheChefzTask-Final
//
//  Created by Noor Walid on 06/08/2022.
//

import Foundation

class MockRealmManager: DatabaseProtocol {
    private var mockData = [Book(value: "Mock1"), Book(value: "Mock2"), Book(value: "Mock3")]
    private var lastSearchKeyword: String?
    
    func save(book: Book) {
        mockData.append(book)
    }
    
    func delete(book: Book) {
        for (index, book) in mockData.enumerated() {
            if book == book {
                mockData.remove(at: index)
            }
        }
    }
    
    func deleteAll() {
        mockData.removeAll()
    }
    
    func fetch(completion: @escaping (([Book]) -> ())) {
        completion(mockData)
    }
    
    func saveLastSearch(keyword: String) {
        lastSearchKeyword = keyword
    }
    
    func fetchLastSearch() -> [LastSearchModel]? {
        let model = LastSearchModel(value: "Mock")
        model.bookTitle = lastSearchKeyword ?? ""
        return [model]
    }
    
    func deleteLastKeyword() {
        lastSearchKeyword = nil
    }
    
}
