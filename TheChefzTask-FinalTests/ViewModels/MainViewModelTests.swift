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
        
        self.cache = MockRealmManager()
        self.network = MockNetworkManager()
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
}
