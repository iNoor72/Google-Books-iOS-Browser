//
//  MainViewModel.swift
//  TheChefzTask
//
//  Created by Noor Walid on 31/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    private let repository: BooksRepository
    
    var lastSearchBehavior = BehaviorRelay<String>(value: "")
    private var booksModelSubject = PublishSubject<[Book]>()
    
    var booksObservable : Observable<[Book]> {
        return booksModelSubject
    }
    
    init(repository: BooksRepository = BooksRepository(cache: RealmManager.shared, network: NetworkManager.shared)) {
        self.repository = repository
    }
    
    func fetchLastSearch() {
        let keyword = repository.fetchLastSearchKeyword()
        lastSearchBehavior = BehaviorRelay.init(value: keyword ?? "No search.")
    }
    
    func fetchBooksFromDatabase() {
        repository.fetchDataFromDatabase { [weak self] books in
            guard let self = self else { return }
            
            self.booksModelSubject.onNext(books)
        }
    }
}
