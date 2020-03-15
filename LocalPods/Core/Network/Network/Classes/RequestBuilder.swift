//
//  RequestBuilder.swift
//  Network
//
//  Created by Artem Kufaev on 13.03.2020.
//

class RequestBuilder {
    public class func build(from route: EndPointType) throws -> URLRequest {
        // Сборка URL из предоставленных данных
        guard let url = URL(string: "\(route.schema)://\(route.host)") else {
            throw NetworkError.missingURL
        }
        var request = URLRequest(url: url.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .requestParameters(let bodyParameters, let urlParameters):
            try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
        }
        if let headers = route.headers {
            self.addAdditionalHeaders(headers, request: &request)
        }
        return request
    }
    
    /// Записывает параметры в запрос
    fileprivate class func configureParameters(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        if let bodyParameters = bodyParameters {
            try URLParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
        }
        if let urlParameters = urlParameters {
            try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
        }
    }
    
    /// Записывает заголовки в запрос
    fileprivate class func addAdditionalHeaders(_ headers: HTTPHeaders, request: inout URLRequest) {
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
