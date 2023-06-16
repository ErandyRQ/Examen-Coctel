//
//  CoctelFavoritoViewModel.swift
//  Examen-Coctel
//
//  Created by MacBookMBA16 on 16/06/23.
//

import Foundation
import CoreData
import UIKit


class CoctelFavoritoViewModel{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
       
       func Add(_ drink : Drink) -> Result{
           var result = Result()
           
           do{
               
           let context = appDelegate.persistentContainer.viewContext
           
           let entity = NSEntityDescription.entity(forEntityName: "VentaProducto", in: context)!
           
           let coctel = NSManagedObject(entity: entity, insertInto: context)
           
           coctel.setValue(drink.idDrink, forKey: "idDrink")
           coctel.setValue(drink.strDrink, forKey: "strDrink")
           coctel.setValue(drink.strInstructions, forKey: "strInstructions")
           coctel.setValue(drink.strIngredient1, forKey: "strIngredient1")
           coctel.setValue(drink.strIngredient2, forKey: "strIngredient2")
           coctel.setValue(drink.strIngredient3, forKey: "strIngredient3")
           coctel.setValue(drink.strDrinkThumb, forKey: "strDrinkThumb")
               try context.save()
               //result.Correct = false
               result.Correct = true
           }
           catch let error {
               result.Correct = false
               result.ErrorMessage = error.localizedDescription
               result.Ex = error
           }
           
           return result
       }
    
    func Delete(_ IdDrink : String) -> Result{
            var result = Result()
            
            do{
                let context = appDelegate.persistentContainer.viewContext
                let response = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
                //response.predicate = NSPredicate(format: "idDrink = %i", IdDrink)
                response.predicate = NSPredicate(format: "idDrink = %@", IdDrink)
                            
                let resultFetch = try context.fetch(response) as? [NSManagedObject]
                let object = resultFetch?.first
                
                context.delete(object!)
                
                do{
                    try context.save()
                    result.Correct = true
                } catch let error{
                    print(error.localizedDescription)
                }
                
            } catch let error{
                result.Correct = false
                result.ErrorMessage = error.localizedDescription
                result.Ex = error
            }
            return result
        }
}
