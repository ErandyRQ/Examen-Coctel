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
          coctel.setValue(drink.strInstructions, forKey: "strInstructions")
          coctel.setValue(drink.strIngredient1, forKey: "strIngredient1")
          coctel.setValue(drink.strIngredient2, forKey: "strIngredient2")
          coctel.setValue(drink.strIngredient3, forKey: "strIngredient3")
          coctel.setValue(drink.strDrinkThumb, forKey: "strDrinkThumb")
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
    
//    func GetAll() -> Result{
//               var result = Result()
//               
//               let context = appDelegate.persistentContainer.viewContext
//               
//               let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
//               
//               do{
//                   result.Objects = []
//                   let resultFetch = try context.fetch(response)
//                   for obj in resultFetch as! [NSManagedObject]{
//                       //Instancia de venta producto //Crear Modelo
//                       let modeloventaproducto = ProductoVentasViewModel()
//                       
//                       modeloventaproducto.producto = Producto()
//                       
//                       modeloventaproducto.producto?.IdProducto =  obj.value(forKey:"idProducto") as! Int
//                       modeloventaproducto.Cantidad = obj.value(forKey: "cantidad") as! Int
//                    
//                       let result1 = ProductosViewModel.GetById(IdProducto: modeloventaproducto.producto?.IdProducto as! Int)
//                       if result1.Correct!{
//                          // let producto = result1.Object! as! Departamento
//                         let producto = result1.Object! as! Producto
//                           
//                           modeloventaproducto.producto?.Nombre = producto.Nombre
//                           modeloventaproducto.producto?.imagen = producto.imagen
//                           modeloventaproducto.producto?.PrecioUnitario = producto.PrecioUnitario
//                       }
//                     
//                       result.Objects?.append(modeloventaproducto)
//                      
//                   }
//                 
//                   result.Correct = true
//               }
//               catch let error {
//                   result.Correct = false
//                   result.ErrorMessage = error.localizedDescription
//                   result.Ex = error
//               }
//               
//               return result
//           }
}
