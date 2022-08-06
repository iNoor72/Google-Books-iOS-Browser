//
//  SearchViewModelTests.swift
//  TheChefzTask-FinalTests
//
//  Created by Noor Walid on 06/08/2022.
//

import XCTest
@testable import TheChefzTask_Final

class SearchViewModelTests: XCTestCase {
    var sut: SearchViewModel!
    var repository: SearchRepository!
    var network: NetworkServiceProtocol!
    var cache: DatabaseProtocol!

    override func setUp() {
        super.setUp()
        
        self.cache = RealmManager.shared
        self.network = NetworkManager.shared
        self.repository = SearchRepository(cache: cache, network: network)
        self.sut = SearchViewModel(repository: repository)
    }
    
    override func tearDown() {
        super.tearDown()
        self.cache = nil
        self.network = nil
        self.repository = nil
        self.sut = nil
    }
    
    func test_save_last_search_keyword() {
        let keyword = "Noor testing"
        sut.saveLastSearch(keyword: keyword)
        
        XCTAssertEqual(keyword, cache.fetchLastSearch()?.first?.bookTitle ?? "WRONG!")
    }
    
    func test_delete_last_search_keyword() {
        let keyword = "Noor testing"
        sut.saveLastSearch(keyword: keyword)
        
        sut.deleteLastSearchKeyword()
        
        XCTAssertNil(cache.fetchLastSearch()?.first?.bookTitle)
    }
}
