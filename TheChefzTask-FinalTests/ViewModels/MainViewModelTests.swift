//
//  MainViewModelTests.swift
//  TheChefzTask-FinalTests
//
//  Created by Noor Walid on 06/08/2022.
//

import XCTest
@testable import TheChefzTask_Final

class MainViewModelTests: XCTestCase {
    var sut: MainViewModel!
    var repository: MainScreenRepository!
    var network: NetworkServiceProtocol!
    var cache: DatabaseProtocol!

    override func setUp() {
        super.setUp()
        
        self.cache = RealmManager.shared
        self.network = NetworkManager.shared
        self.repository = MainScreenRepository(cache: cache, network: network)
        self.sut = MainViewModel(repository: repository)
    }
    
    override func tearDown() {
        super.tearDown()
        self.cache = nil
        self.network = nil
        self.repository = nil
        self.sut = nil
    }
    
    func test_fetch_last_search_keyword() {
        cache.deleteLastKeyword()
        let testKeyword = "Noor testing"
        cache.saveLastSearch(keyword: testKeyword)
        
        sut.fetchLastSearchKeyword()
        
        XCTAssertEqual(testKeyword, repository.fetchLastSearchKeyword())
    }
    
    func test_fetching_books() {
        cache.save(book: Book())
        
        var booksFetched = [Book]()
        sut.fetchBooksFromDatabase()
        
        let expectation = XCTestExpectation(description: "response")
        
        repository.fetchDataFromDatabase { books in
            booksFetched = books
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(booksFetched.isEmpty == false)

    }
}
