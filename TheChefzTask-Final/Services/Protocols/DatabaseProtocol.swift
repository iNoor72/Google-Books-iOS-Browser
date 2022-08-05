//
//  DatabaseProtocol.swift
//  TheChefzTask
//
//  Created by Noor Walid on 30/07/2022.
//

import Foundation

protocol DatabaseProtocol {
    func save(book: Book)
    func delete(book: Book)
    func deleteAll()
    func fetch(completion: @escaping (([Book]) -> ()))
    func saveLastSearch(keyword: String)
    func fetchLastSearch() -> [LastSearchModel]?
    func deleteLastKeyword()
}
