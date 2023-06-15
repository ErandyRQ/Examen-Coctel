//
//  Ingrediente.swift
//  Examen-Coctel
//
//  Created by MacBookMBA16 on 15/06/23.
//

import Foundation
struct Ingrediente : Codable{
    var strDrink : String
    var strDrinkThumb : String
    var idDrink : String
    
    init(){
        self.strDrink = ""
        self.strDrinkThumb = ""
        self.idDrink = ""
    }
}
