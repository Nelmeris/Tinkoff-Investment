//
//  FinnhubDataManagersTests.swift
//  FinnhubDataManager_ExampleTests
//
//  Created by Artem Kufaev on 18.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import FinnhubDataManager
import Network
import Storage
import Nimble

class FinnhubDataManagersTests: XCTestCase {
    
    var provider: ProviderMock!
    
    var ticketStorage: StorageMock<Ticket>!
    var ticketDataManager: TicketDataManager!
    
    var companyStorage: StorageMock<CompanyProfile>!
    var companyProfileDataManager: CompanyProfileDataManager!
    
    var exchangeStorage: StorageMock<Exchange>!
    var exchangeDataManager: ExchangeDataManager!
    
    var newsStorage: StorageMock<News>!
    var newsDataManager: NewsDataManager!

    override func setUp() {
        self.provider = ProviderMock()
        
        self.ticketStorage = StorageMock()
        self.ticketDataManager = TicketDataManager(provider: provider, storage: ticketStorage)
    }
    
    func testTicketsLoad() {
        // Given
        let tickets = [
            Ticket(symbol: "A", displaySymbol: "A", description: "AAA"),
            Ticket(symbol: "B", displaySymbol: "B", description: "BBB")
        ]
        self.provider.stubbedLoadCompletionResult = .success(tickets)
        self.ticketStorage.stubbedReadAllCompletionResult = (tickets, ())
        
        // When
        ticketDataManager.load(exchange: "US") { (result) in
            // Then
            switch result {
            case .success(let loadedTickets):
                XCTAssertEqual(tickets, loadedTickets)
            case .failure(let error):
                XCTFail("Неожиданная ошибка: \(error)")
            }
        }
        
        // Then
        XCTAssert(provider.invokedLoad)
        XCTAssertEqual(provider.invokedLoadCount, 1)
        XCTAssert(ticketStorage.invokedReadAll)
        XCTAssertEqual(ticketStorage.invokedReadAllCount, 1)
    }

}

extension Ticket: Equatable {
    public static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        return lhs.symbol == rhs.symbol &&
            lhs.displaySymbol == rhs.displaySymbol &&
            lhs.description == rhs.description
    }
}
