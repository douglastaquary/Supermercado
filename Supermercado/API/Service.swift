//
//  Service.swift
//  Supermercado
//
//  Created by Douglas Taquary on 29/03/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation
import Combine

struct Service {
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .handleEvents(receiveOutput: { print(NSString(data: $0, encoding: String.Encoding.utf8.rawValue)!) })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
