//
//  CoctelViewModel.swift
//  Examen-Coctel
//
//  Created by MacBookMBA15 on 14/06/23.
//

import Foundation

class CoctelViewModel {
    
    static func GetAll(Response: @escaping(HTTPURLResponse?, Result<Coctel> /*Debe tener el modelo Drinks*/, Error?) -> Void) {
        let urlString = "www.thecocktaildb.com/api/json/v1/1/search.php?f=a"
        let url = URL(string: urlString)!
        var result = Result<Coctel>() // agregar el modelo Drinks
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if let dataSource = data {
                    let decoder = JSONDecoder()
                    let resultSource = decoder.decode(Coctel, from: dataSource)
                    result.Object = resultSource
                    
                    Response(httpResponse, result, nil)
                }
            }
            
            if let errorSource = error {
                Response(nil, nil, errorSource)
            }
        }.resume()
    }
    
    static func GetByName(_ nombre: String, Response: @escaping(HTTPURLResponse?,Result<>/*Aqui Modelo drinks*/ , Error?) -> Void) {
        let urlString = "www.thecocktaildb.com/api/json/v1/1/search.php?s=\(nombre)"
        let url = URL(string: urlString)!
        var result = Result<>() // Agregar el modelo Drinks
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if let dataSource = data {
                    let decoder = JSONDecoder()
                    let resultSource = decoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: dataSource)
                    
                    Response(httpResponse, resultSource, nil)
                }
            }
            
            if let errorSource = error {
                Response(nil, nil, error)
            }
        }.resume()
    }
}
