//
//  DetalleController.swift
//  Examen-Coctel
//
//  Created by Erandy Rosas on 15/06/23.
//

import UIKit

class DetalleController: UIViewController {
    
    @IBOutlet weak var imageCoctel: UIImageView!
    
    @IBOutlet weak var btnMeGusta: UIButton!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblIngrediente1: UILabel!
    
    @IBOutlet weak var lblIngrediente2: UILabel!
    
    @IBOutlet weak var lblIngrediente3: UILabel!
    
    @IBOutlet weak var imageIngrediente1: UIImageView!
    
    @IBOutlet weak var imageIngrediente2: UIImageView!
    
    @IBOutlet weak var imageIngrediente3: UIImageView!
    
    @IBOutlet weak var lblInstrucciones: UILabel!

    let favcoctelViewModel = FavCoctelViewModel()
    
    var ingredientes: [DrinkIngrediente] = []
    var drinks : [Drink] = []
    var idCoctel : String = ""
    var nombre : String = ""
    var ingrediente1 : String = ""
    var ingrediente2 : String = ""
    var ingrediente3 : String = ""
    var instrucciones : String = ""
    var imgUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNombre.text = String(nombre)
        lblIngrediente1.text = String(ingrediente1)
        lblIngrediente2.text = String(ingrediente2)
        lblIngrediente3.text = String(ingrediente3)
        lblInstrucciones.text = String(instrucciones)
        
        
        
        let url = URL(string: "\(imgUrl)/preview")!
        imageCoctel.load(url: url)
        
       
    }
    
    @IBAction func btnmegusta(_ sender: UIButton) {
       
        var drink = Drink()
        
        drink.idDrink = idCoctel
        drink.strDrink = nombre
        drink.strInstructions = instrucciones
        drink.strDrinkThumb = imgUrl
        drink.strIngredient1 = ingrediente1
        drink.strIngredient2 = ingrediente2
        drink.strIngredient3 = ingrediente3
        
        
        
        let result = favcoctelViewModel.Add(drink)
        if result.Correct!{
                    let alert = UIAlertController(title: "Aviso", message: "Bebida agregada a favoritos", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.dismiss(animated: true)
                    })
                    
                    alert.addAction(action)
                    self.present(alert, animated: true)
                    print("Drink agregado")
                }
                else{
                    let alert = UIAlertController(title: "Aviso", message: "Error al agregar bebida a favoritos", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.dismiss(animated: true)
                    })
                    
                    alert.addAction(action)
                    self.present(alert, animated: true)
                    print("Error al agregar Drink")
                }
        
        
        
        
    }
}
