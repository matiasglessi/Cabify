//
//  URLSessionHTTPClientTests.swift
//  CabifyTests
//
//  Created by Matias Glessi on 20/02/2023.
//

import XCTest
@testable import Cabify

final class URLSessionHTTPClientTests: XCTestCase {
    func test_whenSessionHasErrorAndNoData_thenMissingDataErrorIsRetrieved() {
        let session = SessionSpy()
        let clientError = NSError(domain: "Test", code: 0)

        session.complete(with: clientError)
            
        makeSUT(with: session).get(from: URL(string: "http://a-url.com")!) { result in
            switch result {
            case let .failure(error):
                XCTAssertEqual(error as NSError, clientError)
            default:
                XCTFail("Expected error, got \(result) instead.")
            }
        }
    }
    
    func test_whenSessionHasDataAndNoError_ThenTheJSONIsRetrieved() {
        let url = URL(string: "http://a-url.com")!
        let expectedData = makeItemsJSON([])
        let session = SessionSpy()
        session.complete(withStatusCode: 200, url: url, data: expectedData)
        
        let expectation = expectation(description: "Wait for load completion")

        makeSUT(with: session).get(from: url) { (result) in
            switch result {
            case let .success (recievedData, recievedResponse):
                XCTAssertEqual(recievedData, expectedData)
                XCTAssertEqual(recievedResponse.statusCode, 200)
                XCTAssertEqual(recievedResponse.url, url)
            default:
                XCTFail("Expected success, got \(result) instead.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        let itemsJSON = ["products": items]

        guard let json = try? JSONSerialization.data(withJSONObject: itemsJSON) else {
            return Data("invalid json".utf8)
        }
        return json
    }

    
    private func makeSUT(with session: Session) -> HTTPClient {
        let sut = URLSessionHTTPClient(session: session)
        return sut
    }
    
    private class SessionSpy: Session {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        func loadData(from url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
            completionHandler(data, response, error)
        }
        
        func complete(withStatusCode code: Int, url: URL = URL(string: "http://a-url.com")!, data: Data) {
            guard let response = HTTPURLResponse(
                url: url,
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            ) else {
                return
            }
            
            self.data = data
            self.response = response
        }
        
        func complete(with error: Error) {
            self.error = error
        }
    }
}
