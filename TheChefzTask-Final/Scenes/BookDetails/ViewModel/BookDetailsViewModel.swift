//
//  BookDetailsViewModel.swift
//  TheChefzTask
//
//  Created by Noor Walid on 31/07/2022.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class BookDetailsViewModel {
    private var book: Book
    var bookNameBehavior : BehaviorRelay<String>
    var bookPriceBehavior : BehaviorRelay<Double>
    var bookPagesBehavior : BehaviorRelay<Int>
    var bookDescriptionBehavior : BehaviorRelay<String>
    var bookThumbnailBehavior : BehaviorRelay<String>
    var priceCurrencyBehavior : BehaviorRelay<String>
    
    init(book: Book) {
        self.book = book
        self.bookNameBehavior = BehaviorRelay.init(value: book.volumeInfo?.title ?? "No title.")
        self.bookPagesBehavior = BehaviorRelay.init(value: book.volumeInfo?.pageCount ?? 0)
        self.bookPriceBehavior = BehaviorRelay.init(value: book.saleInfo?.listPrice?.amount ?? 0.0)
        self.bookDescriptionBehavior = BehaviorRelay.init(value: book.volumeInfo?.bookDescription ?? "No description.")
        self.bookThumbnailBehavior = BehaviorRelay.init(value: book.volumeInfo?.imageLinks?.thumbnail ?? Constants.defaultImage)
        self.priceCurrencyBehavior = BehaviorRelay.init(value: book.saleInfo?.listPrice?.currencyCode ?? "EGP")
    }
    
    func getBookURL() -> String {
        return book.selfLink ?? ""
    }
}
