//
//  URLSessionFake.swift
//  ConverterServiceTests
//
//  Created by Cedric on 25/04/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class URLSessionFake: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    let urlTask: URLSessionDataTaskFake
    let requestTask: URLSessionDataTaskFake

    init(data: Data?, response: URLResponse?, error: Error?,
         urlTask: URLSessionDataTaskFake, requestTask: URLSessionDataTaskFake) {
        self.data = data
        self.response = response
        self.error = error
        self.urlTask = urlTask
        self.requestTask = requestTask
    }

    override func dataTask(with url: URL,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = urlTask
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }

    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = requestTask
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

    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }

    override func cancel() {}
}
