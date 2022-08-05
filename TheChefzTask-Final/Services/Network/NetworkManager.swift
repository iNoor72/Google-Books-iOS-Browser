//
//  NetworkManager.swift
//  TheChefzTask
//
//  Created by Noor Walid on 30/07/2022.
//

import Foundation
import Alamofire

class NetworkManager: NetworkServiceProtocol {
    static let shared = NetworkManager()
    
    private init() {}
    
    private func getURL(type: ResponseType, bookName: String, page: Int) -> NetworkRouter {
        switch type {
        case .books:
            return NetworkRouter.books(bookName: bookName, page: page)
        }
    }
    
    func fetchData<T:Decodable>(url: NetworkRouter, expectedType: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        AF.request(url).responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}
