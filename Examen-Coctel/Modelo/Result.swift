//
//  Result.swift
//  Examen-Coctel
//
//  Created by MacBookMBA16 on 14/06/23.
//

import Foundation

struct Result {
    
    var Correct : Bool?
    var ErrorMessage : String?
    var Objects : [Any]?
    var Object : Any?
    var Ex : Error?
   
    
    
    init(){
        self.Correct = false
        self.ErrorMessage = ""
        self.Objects = []
        self.Object = nil
    }
}
