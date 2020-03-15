//
//  NetworkError.swift
//  Network
//
//  Created by Artem Kufaev on 13.03.2020.
//

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter encoding failed"
    case missingURL = "URL is nil"
    case decodingFailed = "Decoding data failed"
}
