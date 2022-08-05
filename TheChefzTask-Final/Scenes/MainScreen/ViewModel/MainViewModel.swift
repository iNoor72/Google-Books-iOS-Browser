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
    private let databaseManager: DatabaseProtocol
    
    var lastSearchBehavior = BehaviorRelay<String>(value: "")
    private var booksModelSubject = PublishSubject<[Book]>()
    
    var booksObservable : Observable<[Book]> {
        return booksModelSubject
    }
    
    init(databaseManager: DatabaseProtocol = RealmManager.shared) {
        self.databaseManager = databaseManager
    }
    
    func fetchLastSearch() {
        let keyword = databaseManager.fetchLastSearch()
        lastSearchBehavior = BehaviorRelay.init(value: keyword?.first?.bookTitle ?? "No search.")
    }
    
    func fetchBooksFromDatabase() {
        databaseManager.fetch { [weak self] books in
            guard let self = self else { return }
            
            self.booksModelSubject.onNext(books)
        }
    }
}
