//
//  I_TVShowTests.swift
//  I-TVShowTests
//
//  Created by Fuego on 8/29/20.
//  Copyright © 2020 Kobi Cook. All rights reserved.
//

import XCTest
@testable import I_TVShow

class I_TVShowTests: XCTestCase {

    var service = TvService.shared
    var viewModel: ViewModel!
    
    override func setUpWithError() throws {
        viewModel = ViewModel()
    }

    override func tearDownWithError() throws {
       viewModel = nil
    }

    func testServiceLayer() throws {
        var show: Show?
        let promise = expectation(description: "test after 3 seconds")
        service.get("girls") { result in
            switch result {
            case .failure:
                promise.fulfill()
            case .success(let retrieved):
                show = retrieved
                promise.fulfill()
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(show)
    }


}
