//
//  APIClient.swift
//  APIClientTutorial
//
//  Created by Jean Raphael on 17/02/2018.
//  Copyright © 2018 Jean Raphael Bordet. All rights reserved.
//

import Foundation

public class APIClient {
    private var apiBaseURL: String
    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    
    public var decodeStrategyFormatter: DateFormatter? = nil
    
    convenience init() {
        self.init("")
    }
    
    public init(_ apiBaseURL: String) {
        self.apiBaseURL = apiBaseURL
    }
    
    public func perform<T: APIRequest>(request r: T, completion: @escaping ResultCallback<T.Response>) -> URLSessionTask {
        let endpoint = self.endpoint(for: r)
        
        debugPrint("Starting request \(endpoint)")
        
        let task = session.dataTask(with: endpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            do {
                guard let data = data else { return }

//                Uncommment this line for debug
//                let r = try JSONSerialization.jsonObject(with: data, options: [])
//                debugPrint(r)
                
                if let formatter = self.decodeStrategyFormatter {
                    self.decoder.dateDecodingStrategy = .formatted(formatter)
                }
                
                let result = try self.decoder.decode(T.Response.self, from: data)
                
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
        return task
    }
    
    /// Encodes a URL based on the given request
    /// Everything needed for a public request servers is encoded directly in this URL
    private func endpoint<T: APIRequest>(for request: T) -> URL {
        guard let parameters = try? URLQueryEncoder.encode(request) else { fatalError("Wrong parameters") }
        
        // Construct the final URL with all the previous data
        return URL(string: "\(apiBaseURL)\(request.resourceName)?\(parameters)")!
    }
}
