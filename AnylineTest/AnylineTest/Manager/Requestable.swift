//
//  Requestable.swift
//  AnylineTest
//
//  Created by sajeev Raj on 03/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import Foundation

// protocol for parameters and path
protocol Requestable {
    
    var path: String { get }
        
    var queryParameters: [String: String] { get }
    
    var method: HTTPMethod { get }
        
    func request<T: Codable>(completion: ServiceResponseBlock<T>?)
}

extension Requestable {
    func request<T: Codable>(completion: ServiceResponseBlock<T>?) {
        guard var components = URLComponents(string: ServiceManager.API.baseUrl?.appendingPathComponent(path).absoluteString ?? "") else { return }
        
        let urlQueryItems = queryParameters.map{ return URLQueryItem(name: $0.0, value: $0.1) }
        components.queryItems = urlQueryItems
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        ServiceManager.shared.request(request: request, completion: completion)
    }
}

