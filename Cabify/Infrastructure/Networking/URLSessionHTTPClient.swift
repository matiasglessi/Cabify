//
//  URLSessionHTTPClient.swift
//  Cabify
//
//  Created by Matias Glessi on 20/02/2023.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    private let session: Session
    
    init(session: Session = URLSession.shared) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentationError: Error {}
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.loadData(from: url, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValuesRepresentationError()))
            }
        })
    }
}
