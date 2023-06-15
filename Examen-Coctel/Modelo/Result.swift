//
//  Result.swift
//  Examen-Coctel
//
//  Created by MacBookMBA15 on 14/06/23.
//

import Foundation

struct Result<T: Codable>: Codable {
    
    var Correct : Bool
    var ErrorMessage : String?
    var Object : T?
    var Objects : [T]?
//    var Ex : Error?
    
    init() {
        Correct = false
        ErrorMessage = nil
        Object = nil
        Objects = nil
    }
}
