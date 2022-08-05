//
//  NetworkRouter.swift
//  TheChefzTask
//
//  Created by Noor Walid on 30/07/2022.
//

import Foundation
import Alamofire

enum NetworkRouter: URLRequestConvertible {
    case books(bookName: String, page: Int)

    var path: String {
        switch self {
        case .books:
            return "/volumes"
        }
    }
    
    
    var method: HTTPMethod {
            switch self {
            case .books:
                return .get
            }
        }
        
    //We don't need headers but if needed, uncomment the code and write the headers
    
//    var headers: [String:String] {
//        switch self {
//        case .books(_):
//            return ["":""]
//        }
//    }

    
        var parameters: [String: Any] {
            switch self {
            case .books(let bookName, let pages):
                return ["q":bookName, "maxResults": Constants.defaultMaxNumber, "startIndex": pages]
            }
        }
    
    func asURLRequest() throws -> URLRequest {
        guard var safeURL = URL(string: Constants.baseURL) else { return URLRequest(url: Constants.dummyURL) }
        safeURL.appendPathComponent(path)
        var request = URLRequest(url: safeURL)
        request.method = method
        switch self {
        default:
            request = try URLEncoding.default.encode(request, with: parameters)
        }
        print(request)
        return request
    }
}

