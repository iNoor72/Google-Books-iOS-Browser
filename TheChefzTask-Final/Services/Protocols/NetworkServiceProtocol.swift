//
//  NetworkServiceProtocol.swift
//  TheChefzTask
//
//  Created by Noor Walid on 30/07/2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T:Decodable>(url: NetworkRouter, expectedType: T.Type, completion: @escaping (Result<T, Error>) -> ())
}

protocol NetworkRepositoryProtocol {
    associatedtype T
    var fetchedData : [T] { get set }
}
