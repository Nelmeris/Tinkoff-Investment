//
//  Provider.swift
//  Network
//
//  Created by Artem Kufaev on 13.03.2020.
//

public enum NetworkResult<T> {
    case success(T)
    case failure(NetworkError)
}

public protocol ProviderProtocol {
    associatedtype API
    
    typealias Completion<Model: Decodable> = (_ response: NetworkResult<Model>) -> Void
    
    func load<Model: Decodable>(_ apiMethod: API, completion: @escaping Completion<Model>)
    func cancel()
}

public class Provider<API: INetworkAPI>: ProviderProtocol {
    
    public let session: URLSession
    private var task: URLSessionTask?
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func load<Model: Decodable>(_ apiMethod: API, completion: @escaping Completion<Model>) {
        do {
            let request = try RequestBuilder.build(from: apiMethod)
            task = session.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let parsedData = try JSONDecoder().decode(Model.self, from: data)
                    completion(.success(parsedData))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            }
            self.task?.resume()
        } catch {
            completion(.failure(.encodingFailed))
        }
    }
    
    public func cancel() {
        self.task?.cancel()
    }
    
}
