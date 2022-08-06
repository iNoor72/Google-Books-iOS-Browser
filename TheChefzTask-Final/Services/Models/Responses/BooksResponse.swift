//
//  BookResponse.swift
//  TheChefzTask
//
//  Created by Noor Walid on 30/07/2022.
//

import Foundation
import RealmSwift

class BooksResponse: Object, Codable {
    @Persisted var totalItems: Int = 0
    @Persisted var items = List<Book>()
}

class Book: Object, Codable {
    @Persisted var id: String?
    @Persisted var selfLink: String?
    @Persisted var volumeInfo: VolumeInfo?
    @Persisted var saleInfo: SaleInfo?
}

class VolumeInfo: Object, Codable {
    @Persisted var title: String?
    @Persisted var bookDescription: String?
    @Persisted var pageCount: Int? = 0
    @Persisted var imageLinks: ImageLinks?
    
    enum CodingKeys: String, CodingKey {
        case title, pageCount, imageLinks
        case bookDescription = "description"
    }
}

class ImageLinks: Object, Codable {
    @Persisted var thumbnail: String?
}

class SaleInfo: Object, Codable {
    @Persisted var listPrice: Price?
}

class Price: Object, Codable {
    @Persisted var amount: Double = 0.0
    @Persisted var currencyCode: String?
}
