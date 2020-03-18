import XCTest
import FormattersKit

class ForattersTests: XCTestCase {
    
    override class func setUp() {
        
    }
    
    func testUnix() {
        let formatter = DateFormatter.unix(with: .newsFeedCell)
        let string = formatter.string(fromUnixTimestamp: 1569550360)
        XCTAssertEqual(string, "02:12 19/09/27")
    }
    
}
