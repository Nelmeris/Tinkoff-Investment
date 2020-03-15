//
//  Pincode.swift
//  AuthPinScreen
//
//  Created by Maria on 24.02.2020.
//

class Pincode {
    
    // MARK: - Properties
    var maxLength: Int
    
    var didFinishedEnterPin: ((String) -> Void)?
    
    var code = "" {
        didSet {
            guard code.count == maxLength,
                let didFinishedEnterPin = didFinishedEnterPin else { return }
            didFinishedEnterPin(code)
        }
    }
    
    var hasText: Bool {
        return !code.isEmpty
    }
    
    // MARK: - Lifecycle
    
    init(with length: Int) {
        self.maxLength = length
    }
    
    // MARK: - Public
    
    func insert(_ char: Character) {
        guard code.count != maxLength else { return }
        code.append(char)
    }
    
    func removeLast() {
        guard !code.isEmpty else { return }
        code.removeLast()
    }
    
    func clear() {
        code.removeAll()
    }
    
    func isCodeFill() -> Bool {
        return code.count == maxLength
    }

}
