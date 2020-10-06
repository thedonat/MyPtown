//
//  WebService.swift
//  My Ptown
//
//  Created by Burak Donat on 21.04.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    func performRequest<T: Decodable>(url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return }
<<<<<<< HEAD
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(.network))
                return
=======
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
             completion(NetworkResponse.failure(.network))
>>>>>>> 6443d001a0984aad74e6cd1b874ca62734b1f421
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.decoding))
            }
        }
        task.resume()
    }
}
