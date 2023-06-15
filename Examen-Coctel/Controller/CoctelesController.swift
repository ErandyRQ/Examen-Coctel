//
//  CoctelesController.swift
//  Examen-Coctel
//
//  Created by MacBookMBA16 on 14/06/23.
//

import UIKit

class CoctelesController: UIViewController {

    @IBOutlet weak var itemCocteles: UICollectionView!
    
    
           var drinks : [Drink] = []
           var drinksAMostrar : [Drink] = []
           var Id : String = ""
           var Nombre : String = ""
           var Ingrediente1 : String = ""
           var Ingrediente2 : String = ""
           var Ingrediente3 : String = ""
           var instrucciones : String = ""
           var imgUrl = ""
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        itemCocteles.register(UINib(nibName: "CoctelesCell", bundle: .main), forCellWithReuseIdentifier: "coctelCell")
        itemCocteles.delegate = self
        itemCocteles.dataSource = self
        updateUI()
        // Do any additional setup after loading the view.
        
        
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
        
            return drinks.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coctelCell", for: indexPath) as! CoctelesCell
        
       
            cell.NombreCoctel.text = drinks[indexPath.row].strDrink
            self.imgUrl = drinks[indexPath.row].strDrinkThumb
            let url = URL(string: "\(imgUrl)/preview")!
            cell.imagenCoctel.load(url: url)
        
        

        
        
        
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
        self.instrucciones = drinks[indexPath.row].strInstructions
        self.imgUrl = drinks[indexPath.row].strDrinkThumb
           self.performSegue(withIdentifier: "SegueDescripcion", sender: self)
    }
    
  
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}



