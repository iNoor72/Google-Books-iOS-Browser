//
//  RealmManager.swift
//  TheChefzTask
//
//  Created by Noor Walid on 30/07/2022.
//

import Foundation
import RealmSwift

class RealmManager: DatabaseProtocol {
    static let shared = RealmManager()
    private let localRealm = try! Realm()

    private init() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func deleteLastKeyword() {
        guard let keyword = fetchLastSearch() else { return }
        try? localRealm.write {
            localRealm.delete(keyword)
        }
    }
    
    func saveLastSearch(keyword: String) {
        try? localRealm.write {
            let lastSearchObject = localRealm.create(LastSearchModel.self)
            lastSearchObject.bookTitle = keyword
            localRealm.add(lastSearchObject)
        }
    }
    
    func fetchLastSearch() -> [LastSearchModel]? {
        let lastSearchObject = localRealm.objects(LastSearchModel.self)
        let array = Array(lastSearchObject)
        return array
    }
    
    func save(book: Book) {
        let _ = try? localRealm.write {
            self.localRealm.add(book)
        }
    }
    
    func delete(book: Book) {
        try? localRealm.write {
            localRealm.delete(book)
        }
    }
    
    func deleteAll() {
        var bookArray = [Book]()
        self.fetch { books in
            bookArray = books
        }
        
        let volumeInfoObjects = localRealm.objects(VolumeInfo.self)
        let salesInfoObjects = localRealm.objects(SaleInfo.self)
        let priceObjects = localRealm.objects(Price.self)
        let imageObjects = localRealm.objects(ImageLinks.self)
        try? localRealm.write {
            localRealm.delete(bookArray)
            localRealm.delete(volumeInfoObjects)
            localRealm.delete(salesInfoObjects)
            localRealm.delete(priceObjects)
            localRealm.delete(imageObjects)
        }
    }
    
    func fetch(completion: @escaping (([Book]) -> ())) {
        let books = localRealm.objects(Book.self)
        let booksArray = Array(books)
        completion(booksArray)
    }
}
