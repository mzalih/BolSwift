//
//  XCTest_Extension.swift
//  RecepieTests
//
//  Created by Muhammed salih T A on 30/01/22.
//

import XCTest
import Combine

extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
    
    func bundleURL() -> URL {
        let bundle = Bundle(for: type(of: self))
        return bundle.bundleURL
    }
    
    func loadStub(name: String, extension: String = "json") -> URL? {
        let bundle = Bundle(for: type(of: self))

        let url = bundle.url(forResource: name, withExtension: `extension`)

        return url
    }
    
    func loadStubString(name: String, extension: String) -> String? {
        return loadStub(name: name, extension: `extension`)?.absoluteString
    }

    
     func readLocalJson(forName name: String) -> Data? {
        do {
            if let bundlePath = loadStub(name: name){
                let jsonData = try Data(contentsOf:bundlePath )
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}