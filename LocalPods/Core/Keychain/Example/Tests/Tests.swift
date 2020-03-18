// https://github.com/Quick/Quick

import XCTest
import Keychain

class KeychainTests: XCTestCase {
    
    var keychain: IKeychain!
    
    let key = "SomeKey"
    let value = "SomeValue"
    
    override func setUp() {
        keychain = Keyсhain()
    }
    
    func testSave() {
        _ = keychain.save(key: key, string: value)
        let loadedValue = keychain.load(key: key)
        XCTAssertEqual(value, loadedValue)
    }
    
    func testLoad() {
        let loadedValue = keychain.load(key: key)
        XCTAssertEqual(loadedValue, value)
    }
    
    func testRemove() {
        _ = keychain.remove(key: key)
        let loadedValue = keychain.load(key: key)
        XCTAssertNil(loadedValue)
    }
    
}
