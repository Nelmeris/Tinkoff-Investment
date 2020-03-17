//
//  NetworkError.swift
//  Network
//
//  Created by Artem Kufaev on 13.03.2020.
//

public enum NetworkError: Error, LocalizedError {
    case parametersNil
    case encodingFailed
    case missingURL
    case decodingFailed(Error)
    
    public var localizedDescription: String {
        switch self {
        case .parametersNil: return "Parameters were nil"
        case .encodingFailed: return "Parameter encoding failed"
        case .missingURL: return "URL is nil"
        case .decodingFailed(let error): return "Decoding data failed, error: \(error)"
        }
    }
}
