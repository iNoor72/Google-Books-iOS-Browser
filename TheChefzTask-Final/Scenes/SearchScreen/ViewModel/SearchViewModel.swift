//
//  SearchViewModel.swift
//  TheChefzTask
//
//  Created by Noor Walid on 31/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    private let databaseManager: DatabaseProtocol
    private let networkManager: NetworkServiceProtocol
    
    init(databaseManager: DatabaseProtocol = RealmManager.shared, networkManager: NetworkServiceProtocol = NetworkManager.shared) {
        self.databaseManager = databaseManager
        self.networkManager = networkManager
    }
    
    var books: BooksResponse?
    
    var bookNameBehavior = BehaviorRelay<String>(value: "")
    private var booksModelSubject = BehaviorSubject<[Book]>(value: [])
    
    var booksModelObservable : Observable<[Book]> {
        return booksModelSubject
    }
    
    var isIndicatorOffSubject = BehaviorSubject<Bool>(value: true)
    var isIndicatorHiddenSubject = BehaviorSubject<Bool>(value: true)
    
    func deleteLastSearchResult() {
        databaseManager.deleteAll()
    }
    
    func deleteLastSearchKeyword() {
        databaseManager.deleteLastKeyword()
    }
    
    func saveLastSearch(keyword: String) {
        databaseManager.saveLastSearch(keyword: keyword)
    }
    
    func searchForBook(page: Int) {
        if bookNameBehavior.value == "" {
            return
        }
        self.fetchBooks(bookName: bookNameBehavior.value, page: page)
    }
    
    func saveSearchToDatabase(books: [Book]) {
        for book in books {
            databaseManager.save(book: book)
        }
    }
    
    func loadMoreBooks(page: Int) {
        self.fetchMoreBooks(bookName: bookNameBehavior.value, page: page)
    }
    
    private func fetchMoreBooks(bookName: String, page: Int) {
        self.isIndicatorOffSubject.onNext(false)
        self.isIndicatorHiddenSubject.onNext(false)
        
        networkManager.fetchData(url: .books(bookName: bookName, page: page), expectedType: BooksResponse.self)
        { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print("Error! \(error)")
                
            case .success(let books):
                if let _ = self.books {
                    for book in books.items {
                        self.books?.items.append(book)
                    }
                    let bookItems = Array<Book>(self.books!.items)
                    self.booksModelSubject.onNext(bookItems)
                }
            }
            
            self.isIndicatorOffSubject.onNext(true)
            self.isIndicatorHiddenSubject.onNext(true)
        }
    }
    
    private func fetchBooks(bookName: String, page: Int) {
        self.isIndicatorOffSubject.onNext(false)
        self.isIndicatorHiddenSubject.onNext(false)
        
        networkManager.fetchData(url: .books(bookName: bookName, page: page), expectedType: BooksResponse.self)
        { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print("Error! \(error)")
                
            case .success(let books):
                    self.books = books
                    let bookItems = Array(books.items)
                    self.booksModelSubject.onNext(bookItems)
                    self.deleteLastSearchResult()
                    print(books)
            }
            self.isIndicatorOffSubject.onNext(true)
            self.isIndicatorHiddenSubject.onNext(true)
        }
    }
    
}
