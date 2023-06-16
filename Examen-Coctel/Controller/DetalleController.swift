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
    
    var ingredientes: [DrinkIngrediente] = []
    var drinks : [Drink] = []
    var drinksAMostrar : [Drink] = []
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
    

    

}
