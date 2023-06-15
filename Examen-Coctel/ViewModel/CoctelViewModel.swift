//
//  CoctelViewModel.swift
//  Examen-Coctel
//
//  Created by MacBookMBA15 on 14/06/23.
//

import Foundation

class CoctelViewModel{
    
    static func Get(res : @escaping (Result<Coctel>?,Error?)->Void){
            let url = URL (string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s")!
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let dataSource = data{
                    let decoder = JSONDecoder ( )
                    let result = try! decoder.decode(Result<Coctel>.self, from: dataSource)
                    res (result, nil)
                }
                if let errrSource = error{
                    res(nil,errrSource)
                }
            }.resume ()
        
        
    }
}
