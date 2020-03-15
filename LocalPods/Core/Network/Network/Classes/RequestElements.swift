//
//  RequestElements.swift
//  Network
//
//  Created by Artem Kufaev on 13.03.2020.
//

public enum NetworkSchema {
    case http, https
}

public typealias HTTPHeaders = [String: String]

public typealias Parameters = [String: Any]

public enum HTTPTask {
    case request
    
    case requestParameters(
        bodyParameters: Parameters?,
        urlParameters: Parameters?)
}

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}
