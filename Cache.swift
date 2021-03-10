//
//  Cache.swift
//  Astronomy
//
//  Created by Lorenzo on 3/10/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import Foundation

class Cache<Key: Hashable, Value> {
    private var storage: [Key : Value] = [:]
    private var queue = DispatchQueue(label: "SerialDispatchQueue")

    
    func cache(with value: Value, for key: Key) {
        queue.sync {
            storage[key] = value
        }
    }
    
    subscript(_ key: Key) -> Value? {
            get {
                queue.sync {
                    if let value = storage[key] {
                        return value
                    } else {
                        return nil
                    }
                }
            }
        }
    
}
