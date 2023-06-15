//
//  Result.swift
//  Examen-Coctel
//
//  Created by MacBookMBA16 on 14/06/23.
//

import Foundation
struct Result <T: Codable> : Codable{
    var Correct : Bool?
    var ErrorMessage : String?
    var Objects : [T]?
    var Object : T?
//    var Ex : Error?
   
    
    
    init(){
        self.Correct = false
        self.ErrorMessage = ""
        self.Objects = []
        self.Object = nil
    }
}
