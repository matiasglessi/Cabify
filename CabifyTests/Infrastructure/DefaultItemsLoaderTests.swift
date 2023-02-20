//
//  DefaultItemsLoader.swift
//  CabifyTests
//
//  Created by Matias Glessi on 17/02/2023.
//

import XCTest
@testable import Cabify

class ItemsLoaderTests: XCTestCase {
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        let expectedError = NSError(domain: "Test", code: 0)
        
        client.complete(with: expectedError)

        let expectation = expectation(description: "Wait for load completion")

        sut.load { result in
            switch result {
            case let .failure(recievedError):
                XCTAssertEqual(recievedError as NSError, expectedError)
            default:
                XCTFail("Expected error, got \(result) instead.")
            }
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        let expectedError = NSError(domain: "Test", code: 0)
        
        client.complete(with: expectedError)

        let samples = [199, 201, 300, 400, 500]

        samples.enumerated().forEach { index, code in
            let expectation = expectation(description: "Wait for load completion")
            
            sut.load { result in
                switch result {
                case let .failure(recievedError):
                    XCTAssertEqual(recievedError as NSError, expectedError)
                default:
                    XCTFail("Expected error, got \(result) instead.")
                }
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1.0)
        }
    }
    
    func test_load_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        let jsonData = makeItemsJSON([])
        
        client.complete(withStatusCode: 200, url: url, data: jsonData)
        
        let expectation = expectation(description: "Wait for load completion")
        
        sut.load { result in
            switch result {
            case let .success(recievedItems):
                XCTAssertEqual(recievedItems, [])
            default:
                XCTFail("Expected success, got \(result) instead.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        let item1 = makeItem(code: "A CODE", name: "A given name", price: 10)
        let item2 = makeItem(code: "ANOTHER CODE", name: "Another given name", price: 20.5)

        let jsonData = makeItemsJSON([item1.json, item2.json])
        
        client.complete(withStatusCode: 200, url: url, data: jsonData)
        
        let expectation = expectation(description: "Wait for load completion")
        
        sut.load { result in
            switch result {
            case let .success(recievedItems):
                XCTAssertEqual(recievedItems, [item1.model, item2.model])
            default:
                XCTFail("Expected success, got \(result) instead.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
        
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: DefaultItemsLoader, client: HTTPClientSpy)  {
        let client = HTTPClientSpy()
        let sut = DefaultItemsLoader(url: url, client: client)
        
        return (sut, client)
    }
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        let itemsJSON = ["products": items]

        guard let json = try? JSONSerialization.data(withJSONObject: itemsJSON) else {
            return Data("invalid json".utf8)
        }
        return json
    }
    
    private func makeItem(code: String, name: String, price: Float) -> (model: Item, json: [String: Any]) {
        let item = Item(code: code,
                        name: name,
                        price: price)
        
        let json: [String: Any] = [
            "code": code,
            "name": name,
            "price": price,
        ]
        
        return (item, json)
    }
    
    
    private class HTTPClientSpy: HTTPClient {
        private var result: HTTPClientResult?
        
        func complete(with error: Error) {
            self.result = .failure(error)
        }
        
        func complete(withStatusCode code: Int, url: URL, data: Data) {
            guard let response = HTTPURLResponse(
                url: url,
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            ) else {
                return
            }
            
            self.result = .success(data, response)
        }
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            guard let result = result else { return }
            
            completion(result)
        }
    }
}


