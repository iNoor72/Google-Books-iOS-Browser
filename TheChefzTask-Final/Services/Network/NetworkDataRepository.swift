//
//  NetworkDataRepository.swift
//  TheChefzTask
//
//  Created by Noor Walid on 30/07/2022.
//

import Foundation

class NetworkDataRepository: NetworkRepositoryProtocol {
    typealias T = Book
    
    static let shared = NetworkDataRepository()
    var fetchedData: [T]
    private init() {
        fetchedData = [Book]()
    }
}
