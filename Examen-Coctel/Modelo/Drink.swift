//
//  Drink.swift
//  Examen-Coctel
//
//  Created by MacBookMBA9 on 15/06/23.
//

import Foundation

struct Drink : Codable{
    
    var idDrink : String
    var strDrink : String
    var strCategory : String
    var strDrinkThumb : String
    var strIngredient1 : String
    var strIngredient2 : String
    var strIngredient3 : String?
    var strInstructions : String
    
    init(){
        self.idDrink = ""
        self.strDrink = ""
        self.strCategory = ""
        self.strDrinkThumb = ""
        self.strIngredient1 = ""
        self.strIngredient2 = ""
        self.strIngredient3 = ""
        self.strInstructions = ""
    }
}
