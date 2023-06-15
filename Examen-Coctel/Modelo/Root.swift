//
//  Root.swift
//  Examen-Coctel
//
//  Created by MacBookMBA9 on 15/06/23.
//

import Foundation

struct Root <T : Codable> : Codable{
    
    var drinks : [T]?

    init(){
        
        self.drinks = []
    }
}
