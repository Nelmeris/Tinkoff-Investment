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
        provider = ProviderMock()
        
        ticketStorage = StorageMock()
        ticketDataManager = TicketDataManager(provider: provider, storage: ticketStorage)
        
        companyStorage = StorageMock()
        companyProfileDataManager = CompanyProfileDataManager(provider: provider, storage: companyStorage)
        
        exchangeStorage = StorageMock()
        exchangeDataManager = ExchangeDataManager(provider: provider, storage: exchangeStorage)
        
        newsStorage = StorageMock()
        newsDataManager = NewsDataManager(provider: provider, storage: newsStorage)
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
    
    func testCompanyProfileLoad() {
        // Given
        let companyProfile = CompanyProfile(ticker: "t1", name: "na1", currency: "RU", description: "des1")
        self.provider.stubbedLoadCompletionResult = .success(companyProfile)
        self.companyStorage.stubbedReadAllCompletionResult = ([companyProfile], ())
        
        // When
        companyProfileDataManager.load(with: "t1") { (result) in
            // Then
            switch result {
            case .success(let loadedCompanyProfile):
                XCTAssertEqual(companyProfile, loadedCompanyProfile)
            case .failure(let error):
                XCTFail("Неожиданная ошибка: \(error)")
            }
        }
        
        // Then
        XCTAssert(provider.invokedLoad)
        XCTAssertEqual(provider.invokedLoadCount, 1)
        XCTAssert(companyStorage.invokedReadAll)
        XCTAssertEqual(companyStorage.invokedReadAllCount, 1)
    }
    
    func testExchangeLoad() {
        // Given
        let exchanges = [
            Exchange(name: "A", code: "B", currency: "RU"),
            Exchange(name: "C", code: "F", currency: "USD")
        ]
        self.provider.stubbedLoadCompletionResult = .success(exchanges)
        self.exchangeStorage.stubbedReadAllCompletionResult = (exchanges, ())
        
        // When
        exchangeDataManager.load { (result) in
            // Then
            switch result {
            case .success(let loadedExchanges):
                XCTAssertEqual(exchanges, loadedExchanges)
            case .failure(let error):
                XCTFail("Неожиданная ошибка: \(error)")
            }
        }
        
        // Then
        XCTAssert(provider.invokedLoad)
        XCTAssertEqual(provider.invokedLoadCount, 1)
        XCTAssert(exchangeStorage.invokedReadAll)
        XCTAssertEqual(exchangeStorage.invokedReadAllCount, 1)
    }
    
    func testNewsLoad() {
        // Given
        let news = [
            News(id: 0,
                 image: "http://images.com/1",
                 headline: "head1",
                 summary: "sum1",
                 datetime: 123,
                 related: "rel1",
                 url: URL(string: "https://google.com/")!)
        ]
        self.provider.stubbedLoadCompletionResult = .success(news)
        self.newsStorage.stubbedReadAllCompletionResult = (news, ())
        
        // When
        newsDataManager.load { (result) in
            // Then
            switch result {
            case .success(let loadedNews):
                XCTAssertEqual(news, loadedNews)
            case .failure(let error):
                XCTFail("Неожиданная ошибка: \(error)")
            }
        }
        
        // Then
        XCTAssert(provider.invokedLoad)
        XCTAssertEqual(provider.invokedLoadCount, 1)
        XCTAssert(newsStorage.invokedReadAll)
        XCTAssertEqual(newsStorage.invokedReadAllCount, 1)
    }

}

extension Ticket: Equatable {
    public static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        return lhs.symbol == rhs.symbol &&
            lhs.displaySymbol == rhs.displaySymbol &&
            lhs.description == rhs.description
    }
}

extension News: Equatable {
    public static func == (lhs: News, rhs: News) -> Bool {
        return lhs.id == rhs.id &&
            lhs.datetime == rhs.datetime &&
            lhs.headline == rhs.headline &&
            lhs.image == rhs.image &&
            lhs.related == rhs.related &&
            lhs.summary == rhs.summary
    }
}

extension CompanyProfile: Equatable {
    public static func == (lhs: CompanyProfile, rhs: CompanyProfile) -> Bool {
        return lhs.ticker == rhs.ticker &&
            lhs.name == rhs.name &&
            lhs.currency == rhs.currency &&
            lhs.description == rhs.description
    }
}

extension Exchange: Equatable {
    public static func == (lhs: Exchange, rhs: Exchange) -> Bool {
        return lhs.name == rhs.name &&
            lhs.currency == rhs.currency &&
            lhs.code == rhs.code
    }
}
