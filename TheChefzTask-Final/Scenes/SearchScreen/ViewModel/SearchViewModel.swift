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
    var books: BooksResponse?
    
    var isIndicatorOffSubject = BehaviorSubject<Bool>(value: true)
    var isIndicatorHiddenSubject = BehaviorSubject<Bool>(value: true)
    var bookNameBehavior = BehaviorRelay<String>(value: "")
    
    private var booksModelSubject = BehaviorSubject<[Book]>(value: [])
    
    var booksModelObservable : Observable<[Book]> {
        return booksModelSubject
    }
    
    private let repository: SearchRepository
    
    init(repository: SearchRepository = SearchRepository(cache: RealmManager.shared, network: NetworkManager.shared)) {
        self.repository = repository
    }
    
    func deleteLastSearchResult() {
        repository.deleteLastSearchResultFromDatabase()
    }
    
    func deleteLastSearchKeyword() {
        repository.deleteLastSearchKeywordFromDatabase()
    }
    
    func saveLastSearch(keyword: String) {
        repository.saveLastSearchToDatabase(keyword: keyword)
    }
    
    func searchForBook(page: Int) {
        if bookNameBehavior.value == "" {
            return
        }
        self.fetchBooks(bookName: bookNameBehavior.value, page: page)
    }
    
    func saveSearchToDatabase(books: [Book]) {
        for book in books {
            repository.saveSearchResultToDatabase(book: book)
        }
    }
    
    func loadMoreBooks(page: Int) {
        self.fetchMoreBooks(bookName: bookNameBehavior.value, page: page)
    }
    
    private func fetchMoreBooks(bookName: String, page: Int) {
        self.isIndicatorOffSubject.onNext(false)
        self.isIndicatorHiddenSubject.onNext(false)
        
        repository.fetchBooksFromNetwork(bookName: bookName, page: page) { [weak self] result in
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
        
        repository.fetchBooksFromNetwork(bookName: bookName, page: page) { [weak self] result in
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
