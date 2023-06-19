//
//  CoctelesController.swift
//  Examen-Coctel
//
//  Created by MacBookMBA16 on 14/06/23.
//

import UIKit

class CoctelesController: UIViewController {

    @IBOutlet weak var sbBuscar: UISearchBar!
    @IBOutlet weak var scSelect: UISegmentedControl!
    @IBOutlet weak var itemCocteles: UICollectionView!
    
           var ingredientes: [DrinkIngrediente] = []
           var drinks : [Drink] = []
         //  var drinksAMostrar : [Drink] = []
           var Id : String = ""
           var Nombre : String = ""
           var Ingrediente1 : String = ""
           var Ingrediente2 : String = ""
           var Ingrediente3 : String = ""
         //  var instrucciones : String = ""
           var imgUrl = ""
    var DrinkDetail : Drink? = nil
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        itemCocteles.register(UINib(nibName: "CoctelesCell", bundle: .main), forCellWithReuseIdentifier: "coctelCell")
        itemCocteles.delegate = self
        itemCocteles.dataSource = self
        updateUI()
        
        
        
    }
    
    func updateUI(){
        CoctelViewModel.GetAll { result, error in
            if let resultSource = result{
                for objdrinks in resultSource.drinks!{
                    let drink = objdrinks
                    self.drinks.append(drink)
                }
                DispatchQueue.main.async {
                    self.itemCocteles.reloadData()
                }
            }
        }
    }
}

extension CoctelesController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if drinks.count > 0 {
            return drinks.count
        }
        else {
            return ingredientes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coctelCell", for: indexPath) as! CoctelesCell
        
        if drinks.count > 0 {
            
            cell.NombreCoctel.text = drinks[indexPath.row].strDrink
            self.imgUrl = drinks[indexPath.row].strDrinkThumb
            let url = URL(string: "\(imgUrl)/preview")!
            cell.imagenCoctel.load(url: url)
            
            //        } else {
            //
            //                 cell.NombreCoctel.text = ingredientes[indexPath.row].strDrink
            //                 self.imgUrl = ingredientes[indexPath.row].strDrinkThumb
            //                 let url = URL(string: "\(imgUrl)/preview")!
            //                 cell.imagenCoctel.load(url: url)
            //
            //        }
            
            
        }

            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if !drinks.isEmpty {
                Id = drinks[indexPath.row].idDrink
                print(Id)
                Nombre = drinks[indexPath.row].strDrink
                DrinkDetail = drinks[indexPath.row]
                print(Nombre)
                
                //self.instrucciones = drinks[indexPath.row].strInstructions
                self.imgUrl = drinks[indexPath.row].strDrinkThumb
            } else if !ingredientes.isEmpty{
                // Agregue esta parte para la parte de la busqueda por ingrediente
                Id = ingredientes[indexPath.row].idDrink
            }
            self.performSegue(withIdentifier: "SegueDescripcion", sender: self)
        }
        
        //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        //                if segue.identifier == "SegueDescripcion"{
        //                    let formControl = segue.destination as! DetalleController
        //                    if scSelect.selectedSegmentIndex == 0 {
        //                        formControl.DrinkDetail = self.DrinkDetail
        //                    }
        //                    if scSelect.selectedSegmentIndex == 1 {
        //                        formControl.idCoctel = self.Id
        //                    }
        //                }
        //            }
        
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "SegueDescripcion"{
                let formControl = segue.destination as! DetalleController
                formControl.idCoctel = self.Id
                formControl.nombre = self.Nombre
                formControl.ingrediente1 = self.Ingrediente1
                formControl.ingrediente2 = self.Ingrediente2
                formControl.ingrediente3 = self.Ingrediente3
                //       formControl.instrucciones = self.instrucciones
                formControl.imgUrl = self.imgUrl
                
            }
        }
        
        
    
    //extension UIImageView {
    //    func load(url: URL) {
    //        DispatchQueue.global().async { [weak self] in
    //            if let data = try? Data(contentsOf: url) {
    //                if let image = UIImage(data: data) {
    //                    DispatchQueue.main.async {
    //                        self?.image = image
    //                    }
    //                }
    //            }
    //        }
    //    }
    //}
}

extension CoctelesController: UISearchBarDelegate {
    
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
                        self.itemCocteles.reloadData()
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
                        self.itemCocteles.reloadData()
                        searchBar.endEditing(true)
                    }
                }
            })
        }
    }
 
}

