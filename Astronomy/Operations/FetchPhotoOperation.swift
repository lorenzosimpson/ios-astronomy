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
    
    private var dataTask: URLSessionDataTask {
        let url = marsPhotoReference.imageURL
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching image from Mars Photo reference URL, \(error)")
                return
            }
            guard let data = data else {
                print("No data from request")
                return
            }
            self.imageData = data
        }
        return task
    }
    
    override func start() {
        state = .isExecuting
        dataTask.resume()
        state = .isFinished
    }
    
    override func cancel() {
        dataTask.cancel()
    }
    
}
