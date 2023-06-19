//
//  FavCoctelViewModel.swift
//  Examen-Coctel
//
//  Created by MacBookMBA16 on 16/06/23.
//

import Foundation
import CoreData
import UIKit

class FavCoctelViewModel{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
      
     func Add(_ drink : Drink) -> Result{
          var result = Result()
          
          do{
              
           let context = appDelegate.persistentContainer.viewContext
             
          let entity = NSEntityDescription.entity(forEntityName: "CoctelCD", in: context)!
          
          let coctel = NSManagedObject(entity: entity, insertInto: context)
          
          coctel.setValue(drink.idDrink, forKey: "idDrink")
          coctel.setValue(drink.strDrink, forKey: "strDrink")
        //  coctel.setValue(drink.strInstructions, forKey: "strInstructions")
          coctel.setValue(drink.strDrinkThumb, forKey: "strDrinkThumb")
          coctel.setValue(drink.strIngredient1, forKey: "strIngredient1")
          coctel.setValue(drink.strIngredient2, forKey: "strIngredient2")
          coctel.setValue(drink.strIngredient3, forKey: "strIngredient3")
          
          try context.save()
       
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
               let response = NSFetchRequest<NSFetchRequestResult>(entityName: "CoctelCD")
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
    
         
    func GetAll() -> Result{
                var result = Result()

                do{
                    let context = appDelegate.persistentContainer.viewContext
                    let response = NSFetchRequest<NSFetchRequestResult>(entityName: "CoctelCD")

                    let resultFetch = try context.fetch(response)

                    result.Objects = []

                    for objDrink in resultFetch as! [NSManagedObject]{
                        var drink = Drink()

                        drink.idDrink = objDrink.value(forKey: "idDrink") as! String
                        drink.strDrink = objDrink.value(forKey: "strDrink") as! String
                         //drink.strCategory = objDrink.value(forKey: "strCategory") as! String
                        drink.strDrinkThumb = objDrink.value(forKey: "strDrinkThumb") as! String
                        drink.strIngredient1 = objDrink.value(forKey: "strIngredient1") as! String
                        drink.strIngredient2 = objDrink.value(forKey: "strIngredient2") as! String
                        drink.strIngredient3 = objDrink.value(forKey: "strIngredient3") as? String
                        //drink.strInstructions = objDrink.value(forKey: "strInstructions") as! String
                        
                        result.Objects!.append(drink)
                        result.Correct = true
                    }


        //            result.Correct = true
                }
                catch let error{
                    result.Correct = false
                    result.ErrorMessage = error.localizedDescription
                    result.Ex = error
                }

                return result
            }
}
