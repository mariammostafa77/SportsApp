//
//  NetworkServicesTest.swift
//  SportsAppTests
//
//  Created by mariam mostafa on 5/20/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import XCTest
@testable import SportsApp

class NetworkServicesTest: XCTestCase {

    let myService=NetworkServices()
    let service = NetworkServices()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetAllSportsFromNetwork(){
        let expext = expectation(description: "Waiting For the API....")
        service.getAllSportsFromNetwork { (items) in
            guard let items = items else{
                XCTFail()
                expext.fulfill()
                return
            }
            XCTAssertEqual(items.count, 34,"API Faild..")
            expext.fulfill()
        }
       waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchTeamData(){
        let expext = expectation(description: "Waiting For the API....")
        service.fetchTeamData(parametrs: ["l": "Albanian Superliga"]) { (teamData) in
            guard let items = teamData else{
                XCTFail()
                expext.fulfill()
                return
            }
            XCTAssertEqual(items.count, 10,"API Faild..")
            expext.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchSLeagesResultWithAF(){
    }
    
    func testFetchSLeagesDetailsTest(){
        
    }
    
    
    
    
    
    
}
