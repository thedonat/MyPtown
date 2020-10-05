//
//  WebService.swift
//  My Ptown
//
//  Created by Burak Donat on 21.04.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    func performRequest<T: Decodable>(url: String, completion: @escaping (NetworkResponse<T, NetworkError>) -> Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(NetworkResponse.failure(.network))
                } else {
                    if let safeData = data {
                        if let decodedData = try? JSONDecoder().decode(T.self, from: safeData) {
                            completion(NetworkResponse.success(decodedData))
                        } else {
                            completion(NetworkResponse.failure(.decoding))
                        }
                    }
                }
            }.resume()
        }
    }
}
