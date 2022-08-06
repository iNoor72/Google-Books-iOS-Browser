//
//  MockNetworkManager.swift
//  TheChefzTask-Final
//
//  Created by Noor Walid on 06/08/2022.
//

import Foundation

class MockNetworkManager: NetworkServiceProtocol {
    private let mockData = [Book(value: "Mock1"), Book(value: "Mock2"), Book(value: "Mock3")]
    
    func fetchData<T>(url: NetworkRouter, expectedType: T.Type, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        completion(.success(mockData as! T))
    }
}
