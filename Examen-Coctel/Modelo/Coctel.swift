//
//  Coctel.swift
//  Examen-Coctel
//
//  Created by MacBookMBA16 on 14/06/23.
//

import Foundation
struct Coctel : Codable{
    
    var idDrink : String
    var strDrink : String?
    var strIngredient1 : String?
    
    init(){
        self.idDrink = ""
        self.strDrink = ""
        self.strIngredient1 = ""
    }
}
