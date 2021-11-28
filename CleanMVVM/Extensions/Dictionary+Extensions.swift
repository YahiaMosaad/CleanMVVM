//
//  Dictionary+Extensions.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
extension Dictionary {
    func mergedWith(_ dictionary: [Key : Value]?) -> [Key : Value] {
        if let dictionary = dictionary {
            return self.merging(dictionary) { (_, new) -> Value in new }
        } else {
            return self
        }
    }
}
