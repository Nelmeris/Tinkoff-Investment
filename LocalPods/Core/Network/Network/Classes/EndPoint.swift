//
//  EndPoint.swift
//  Network
//
//  Created by Artem Kufaev on 13.03.2020.
//

public protocol EndPointType {
    var schema: NetworkSchema { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
