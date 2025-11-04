//
//  ObservableArray.swift
//  Assignment-suraj
//
//  Created by suraj_kumar on 01/11/25.
//

import Foundation

class ObservableArray<T>: ObservableObject {
    @Published var array: [T]
    init(array: [T]) {
        self.array = array
    }
}
