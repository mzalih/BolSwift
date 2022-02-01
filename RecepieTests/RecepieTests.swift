//
//  RecepieTests.swift
//  RecepieTests
//
//  Created by Muhammed salih T A on 27/01/22.
//

import XCTest
@testable import Recepie
import Combine
@testable import MNetwork

class RecepieTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchList() throws{
        
        let data = readLocalJson(forName: "RecepieList")
        let urlString = (url.baseurl + url.product)
        let session = URLSession
            .mock(mocks:[urlString.toUrl :
                    URLSession
                    .mockResponse(
                        urlString: urlString,
                        responseData: data)])
        
        let viewModel =  ReceipieListViewController.ViewModel(service: APIReceipieServices(session: session));
        let response  = try awaitPublisher( viewModel.loadData())
        XCTAssertEqual(response, true)
        XCTAssertEqual(viewModel.loading, false)
        XCTAssertEqual(viewModel.items.count, 5)
    }

}
extension XCTestCase: AddLocalTestFile{
    
}
