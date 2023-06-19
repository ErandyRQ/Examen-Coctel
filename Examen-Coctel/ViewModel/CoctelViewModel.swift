//
//  CoctelViewModel.swift
//  Examen-Coctel
//
//  Created by MacBookMBA15 on 14/06/23.
//

import Foundation

class CoctelViewModel{
    
    static func GetAll(resp: @escaping(Root<Drink>?, Error?) -> Void){
               let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s")!
               
               URLSession.shared.dataTask(with: url){data, response, error in
                   let httpResponse = response as! HTTPURLResponse
                   if 200...299 ~= httpResponse.statusCode{
                       if let dataSource = data{
                           let decoder = JSONDecoder()
                           let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
       //                    print(jsonString)
                           let result = try! decoder.decode(Root<Drink>.self, from: dataSource)
                           resp(result, nil)
                       }
                       if let errorSource = error{
                           resp(nil, errorSource)
                       }
                   }
                   
               }.resume()
           }
       
       static func GetByNombre(_ nombre : String, resp: @escaping(Root<Drink>?, Error?) -> Void){
               let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(nombre)")!
               
               URLSession.shared.dataTask(with: url){data, response, error in
                   let httpResponse = response as! HTTPURLResponse
                   if 200...299 ~= httpResponse.statusCode{
                       if let dataSource = data{
                           let decoder = JSONDecoder()
                           let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
       //                    print(jsonString)
                           let result = try! decoder.decode(Root<Drink>.self, from: dataSource)
                           resp(result, nil)
                       }
                       if let errorSource = error{
                           resp(nil, errorSource)
                       }
                   }
                   
               }.resume()
           }
           
           static func GetByIngrediente(_ nombre : String, resp: @escaping(Root<DrinkIngrediente>?, Error?) -> Void){
               let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(nombre)")!
               
               URLSession.shared.dataTask(with: url){data, response, error in
                   let httpResponse = response as! HTTPURLResponse
                   if 200...299 ~= httpResponse.statusCode{
                       if let dataSource = data{
                           let decoder = JSONDecoder()
                           let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
       //                    print(jsonString)
                           let result = try! decoder.decode(Root<DrinkIngrediente>.self, from: dataSource)
                           resp(result, nil)
                       }
                       if let errorSource = error{
                           resp(nil, errorSource)
                       }
                   }
                   
               }.resume()
           }
    
    static func GetById(_ idCoctel: String, resp: @escaping(Root<Drink>?, Error?) -> Void) {
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(idCoctel)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            let httpResponse = response as! HTTPURLResponse
            if 200...299 ~= httpResponse.statusCode {
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
//                    print(jsonString)
                    let result = try! decoder.decode(Root<Drink>.self, from: dataSource)
                    resp(result, nil)
                }
                if let errorSource = error{
                    resp(nil, errorSource)
                }
            }
        }.resume()
    }
    
}
