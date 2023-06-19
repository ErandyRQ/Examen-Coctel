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
    
    @IBOutlet weak var cvIngredientes: UICollectionView!
    
    @IBOutlet weak var lblInstrucciones: UILabel!

    let favcoctelViewModel = FavCoctelViewModel()
    
    var ingredientes: [String] = []
    var drinks : [Drink] = []
    var idCoctel : String = ""
    var nombre : String = ""
    var ingrediente1 : String = ""
    var ingrediente2 : String = ""
    var ingrediente3 : String = ""
    var instrucciones : String = ""
    var imgUrl = ""
    let imgIngredienteUrl = "https://www.thecocktaildb.com/images/ingredients/"
    var DrinkDetail: Drink? = nil
    var fav: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        lblNombre.text = String(nombre)
//        lblIngrediente1.text = String(ingrediente1)
//        lblIngrediente2.text = String(ingrediente2)
//        lblIngrediente3.text = String(ingrediente3)
//        lblInstrucciones.text = String(instrucciones)
//
//
//
//        let url = URL(string: "\(imgUrl)/preview")!
//        imageCoctel.load(url: url)
        cvIngredientes.register(UINib(nibName: "CoctelesCell", bundle: .main), forCellWithReuseIdentifier: "coctelCell")
        cvIngredientes.delegate = self
        cvIngredientes.dataSource = self
        
        if idCoctel != "" {
            GetDetails()
        } else {
            let url = URL(string: "\(DrinkDetail!.strDrinkThumb)/preview")!
            imageCoctel.load(url: url)
            lblInstrucciones.text = String(DrinkDetail!.strInstructions)
            lblNombre.text = String(DrinkDetail!.strDrink)
            GetIngredientes()
            let checkFav = favcoctelViewModel.GetById(DrinkDetail!.idDrink)
            if checkFav.Correct! {
                btnMeGusta.imageView?.image = UIImage(systemName: "heart.fill")
                fav = true
            }
        }
       
    }
    
    private func GetDetails() {
        CoctelViewModel.GetById(idCoctel) { result, error in
            if let resultSource = result{
                if let drink = resultSource.drinks?.first {
                    self.DrinkDetail = drink
                    self.idCoctel = drink.idDrink
                    self.GetIngredientes()
                    DispatchQueue.main.async {
                        let checkFav = self.favcoctelViewModel.GetById(self.idCoctel)
                        if checkFav.Correct! {
                            self.btnMeGusta.imageView?.image = UIImage(systemName: "heart.fill")
                            self.fav = true
                        }
                        self.lblNombre.text = self.DrinkDetail!.strDrink
                        self.lblInstrucciones.text = self.DrinkDetail!.strInstructions
                        let url = URL(string: "\(self.DrinkDetail!.strDrinkThumb)/preview")!
                        self.imageCoctel.load(url: url)
                        self.cvIngredientes.reloadData()
                    }
                }
            }
        }
    }
    
    private func GetIngredientes() {
        let mirror = Mirror(reflecting: DrinkDetail!)
        for child in mirror.children {
            if let val = child.label {
                if val.contains("strIngredient") {
                    if let value = child.value as? String {
                        ingredientes.append(value)
                    }
                }
            }
        }
    }
    
    private func getImg(_ ingrediente: String) -> URL {
        let newString = ingrediente.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        let url = URL(string: "\(imgIngredienteUrl)\(newString).png")!
        
        return url
    }
    @IBAction func btnmegusta(_ sender: UIButton) {
       
        var drink = Drink()
        
        drink.idDrink = DrinkDetail!.idDrink
        drink.strDrink = DrinkDetail!.strDrink
        drink.strInstructions = DrinkDetail!.strInstructions
        drink.strDrinkThumb = DrinkDetail!.strDrinkThumb
        drink.strIngredient1 = DrinkDetail!.strIngredient1
        drink.strIngredient2 = DrinkDetail!.strIngredient2
        drink.strIngredient3 = DrinkDetail!.strIngredient3
        
        if fav {
            let result = favcoctelViewModel.Delete(idCoctel)
            if result.Correct! {
                let alert = UIAlertController(title: "Aviso", message: "Bebida eliminada de favoritos", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) {_ in
                    self.dismiss(animated: true)
                    self.btnMeGusta.imageView?.image = UIImage(systemName: "heart")
                }
                alert.addAction(action)
                self.present(alert, animated: true)
                print("Drink eliminado")
            } else {
                let alert = UIAlertController(title: "Aviso", message: "Error al eliminar bebida de favoritos", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.dismiss(animated: true)
                })
                
                alert.addAction(action)
                self.present(alert, animated: true)
                print("Error al agregar Drink")
                
            }
        } else {
            
            let result = favcoctelViewModel.Add(drink)
            if result.Correct!{
                let alert = UIAlertController(title: "Aviso", message: "Bebida agregada a favoritos", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.dismiss(animated: true)
                    self.btnMeGusta.imageView?.image = UIImage(systemName: "heart.fill")
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
}

extension DetalleController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredientes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "coctelCell", for: indexPath) as? CoctelesCell {
            celda.NombreCoctel.text = ingredientes[indexPath.row]
            celda.imagenCoctel.load(url: getImg(ingredientes[indexPath.row]))
            
            return celda
        }
        return UICollectionViewCell()
    }

}
