//
//  URLSessionFake.swift
//  WeatherServiceTests
//
//  Created by Cedric on 18/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class URLSessionFake: URLSession {
    let data: Data?
    let response: URLResponse?
    let error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
// Gives Fake data for tests.
    override func dataTask(with url: URL,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
// Gives Fake data for tests.
    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        task.resume()
        return task
    }
}

class URLSessionDataTaskFake: URLSessionDataTask {
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
// Overrides the completionHandler of the resume func.
    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }

    override func cancel() {}
}
