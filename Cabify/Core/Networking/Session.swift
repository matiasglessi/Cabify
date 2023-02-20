//
//  Session.swift
//  Cabify
//
//  Created by Matias Glessi on 20/02/2023.
//

import Foundation
protocol Session {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: Session {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }
    
        task.resume()
    }
}
