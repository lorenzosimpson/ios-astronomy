//
//  FetchPhotoOperation.swift
//  Astronomy
//
//  Created by Lorenzo on 3/10/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import Foundation

class FetchPhotoOperation: ConcurrentOperation {
    var marsPhotoReference: MarsPhotoReference
    var imageData: Data?
    
    
    init(marsPhotoReference: MarsPhotoReference) {
        self.marsPhotoReference = marsPhotoReference
    }
    
    private var dataTask: URLSessionDataTask?
    
    override func start() {
        state = .isExecuting
        guard let url = marsPhotoReference.imageURL.usingHTTPS else {
            print("Not using a secure connection")
            state = .isFinished
            return
        }
        let request = URLRequest(url: url)
        dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            defer {
                self.state = .isFinished
            }
            
            if let error = error {
                print("Error fetching image from Mars Photo reference URL, \(error)")
                return
            } else {
                if let data = data {
                    self.imageData = data
                    return
                }
            }
        }
        dataTask?.resume()
    }
    
    override func cancel() {
        dataTask?.cancel()
        state = .isFinished
    }
    
}
