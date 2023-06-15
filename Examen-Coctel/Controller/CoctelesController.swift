//
//  CoctelesController.swift
//  Examen-Coctel
//
//  Created by MacBookMBA16 on 14/06/23.
//

import UIKit

class CoctelesController: UIViewController {

    @IBOutlet weak var itemCocteles: UICollectionView!
    
    var coctel : [Coctel] = []
    var result = Result<Coctel>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        itemCocteles.register(UINib(nibName: "coctelCell", bundle: .main), forCellWithReuseIdentifier: "coctelCell")
        itemCocteles.delegate = self
        itemCocteles.dataSource = self
        updateUI()
        // Do any additional setup after loading the view.
        
        
    }
    

   
    
    

}
extension CoctelesController :  UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "coctelCell", for: indexPath) as! CoctelesCell
        cell.NombreCoctel.text = coctel[indexPath.row].strDrink
//        if area[indexPath.row].Nombre ==  area[indexPath.row].Nombre {
//            cell.imagenmostrar.image = UIImage(named: "\(area[indexPath.row].Nombre!)")
//        }else{
//            //let imagenData : Data = //Proceso inverso de base64 a Data
//            //cell.imageView.image = UIImage(data: imagenData)
//        }
        return cell
    }
    
    func updateUI(){
        coctel.removeAll()
        var result = CoctelViewModel.Get{[self] result, error in
            if let resultsoucer = result{
                self.result = resultsoucer
                if result?.Correct == true{
                    for objCoctel in result!.Objects!{
                        let coctelres = objCoctel as! Coctel //Unboxing
                        coctel.append(coctelres)
                        DispatchQueue.main.async {
                            self.itemCocteles.reloadData()
                        }
                        
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("seleciono \(area[indexPath.row].IdArea)")
        
        self.performSegue(withIdentifier: "SegueDepartamento", sender: self)
        }
    
   
}



