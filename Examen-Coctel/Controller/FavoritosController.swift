//
//  FavoritosController.swift
//  Examen-Coctel
//
//  Created by MacBookMBA9 on 19/06/23.
//

import UIKit

class FavoritosController: UIViewController {
    
    @IBOutlet weak var sbBuscar: UISearchBar!
    @IBOutlet weak var scSelect: UISegmentedControl!
    
    @IBOutlet weak var viewCollection: UICollectionView!
 
    var ingredientes: [DrinkIngrediente] = []
    var drinks : [Drink] = []
    var drinksAMostrar : [Drink] = []
    var Id : String = ""
    var Nombre : String = ""
    var Ingrediente1 : String = ""
    var Ingrediente2 : String = ""
    var Ingrediente3 : String = ""
   // var instrucciones : String = ""
    var imgUrl = ""
    var DrinkDetail : Drink? = nil
    
    var favCoctel = FavCoctelViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Id)
        
        viewCollection.register(UINib(nibName: "CoctelesCell", bundle: .main), forCellWithReuseIdentifier: "coctelCell")
        viewCollection.delegate = self
        viewCollection.dataSource = self
        updateUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.updateUI()
     }
     
    func updateUI(){
        let result = favCoctel.GetAll()
              drinks.removeAll()
              if result.Correct!{
                  for objDrink in result.Objects!{
                      let drink = objDrink as! Drink
                      drinks.append(drink)

                  }
                  viewCollection.reloadData()
              }
              else{
                 // print("Ocurrio un error \(result.ErrorMessage)")
              }
    }

}
extension FavoritosController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
            return drinks.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coctelCell", for: indexPath) as! CoctelesCell
        
        if drinks.count > 0 {
            
                 cell.NombreCoctel.text = drinks[indexPath.row].strDrink
                 self.imgUrl = drinks[indexPath.row].strDrinkThumb
                 let url = URL(string: "\(imgUrl)/preview")!
                 cell.imagenCoctel.load(url: url)
            
        }
        
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Id = drinks[indexPath.row].idDrink
           print(Id)
        Nombre = drinks[indexPath.row].strDrink
        print(Nombre)
        self.Ingrediente1 = drinks[indexPath.row].strIngredient1
        self.Ingrediente2 = drinks[indexPath.row].strIngredient2
        self.Ingrediente3 = drinks[indexPath.row].strIngredient3 ?? "No tiene ingrediente"
     //   self.instrucciones = drinks[indexPath.row].strInstructions
        self.imgUrl = drinks[indexPath.row].strDrinkThumb
           self.performSegue(withIdentifier: "SegueDescripcion", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               
                if segue.identifier == "SegueDescripcion"{
                    let formControl = segue.destination as! DetalleController
                    formControl.idCoctel = self.Id
                    formControl.nombre = self.Nombre
                    formControl.ingrediente1 = self.Ingrediente1
                    formControl.ingrediente2 = self.Ingrediente2
                    formControl.ingrediente3 = self.Ingrediente3
      //              formControl.instrucciones = self.instrucciones
                    formControl.imgUrl = self.imgUrl
                    
                }
            }
    
  
}
extension FavoritosController: UISearchBarDelegate {
    
    //func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    //}
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if self.scSelect.selectedSegmentIndex == 0 {
            let nombre = sbBuscar.text!
            CoctelViewModel.GetByNombre(nombre.lowercased(), resp: { result, error in
                if let resultSource = result{
                    self.drinks.removeAll()
                    self.ingredientes.removeAll()
                    for objdrinks in resultSource.drinks!{
                        let drink = objdrinks
                        self.drinks.append(drink)
                    }
                    DispatchQueue.main.async {
                        self.viewCollection.reloadData()
                        searchBar.endEditing(true)
                    }
                }
            })
        }
        else if self.scSelect.selectedSegmentIndex == 1 {
            let ingrediente = sbBuscar.text!
            CoctelViewModel.GetByIngrediente(ingrediente, resp: { result, error in
                if let resultSource = result{
                    self.drinks.removeAll()
                    self.ingredientes.removeAll()
                    for objdrinks in resultSource.drinks!{
                        let drink = objdrinks
                        self.ingredientes.append(drink)
                    }
                    DispatchQueue.main.async {
                        self.viewCollection.reloadData()
                        searchBar.endEditing(true)
                    }
                }
            })
        }
    }
 
}






