//
//  CatLinkProviderTest.swift
//  CatBrowserTests
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

import XCTest
@testable import CatBrowser

class CatLinkProviderTest: XCTestCase {

    private var provider: CatLinkProvider!
    
    override func setUp() {
        provider = CatLinkProvider(itemsPerPage: 100, firstPage: 0)
    }
    
    func testProviderReturnsCorrectLink() {
        let expected = "https://api.thecatapi.com/v1/images/search?limit=100&page=0&order=Desc"
        let result = provider.getNextLink()
        XCTAssertEqual(expected, result)
    }

}
