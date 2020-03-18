//
//  Network_ExampleTests.swift
//  Network_ExampleTests
//
//  Created by Artem Kufaev on 18.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import Network_Example
import Network
import Nimble

class NetworkTicketsTests: XCTestCase {
    
    var provider: Provider<TicketAPI>!

    override func setUp() {
        provider = Provider<TicketAPI>()
    }

    override func tearDown() {
        provider.cancel()
    }

    func testLoadTickets() {
        waitUntil(timeout: 10) { (done) in
            self.provider.load(.stockSymbol(exchange: "US")) { (result: NetworkResult<[Ticket]>) in
                switch result {
                case .success(let tickets):
                    XCTAssertFalse(tickets.isEmpty, "Result is empty")
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                done()
            }
        }
    }
    
    func testCancelRequest() {
        let time: TimeInterval = 5
        waitUntil(timeout: time) { (done) in
            self.provider.load(.stockSymbol(exchange: "US")) { (result: NetworkResult<[Ticket]>) in
                switch result {
                case .success(let tickets):
                    print(tickets)
                case .failure(let error):
                    print(error)
                }
                XCTFail("Request is not canceled")
                done()
            }
            self.provider.cancel()
            _ = Timer.scheduledTimer(withTimeInterval: time - 1, repeats: true) { (_) in
                done()
            }
        }
    }

}
