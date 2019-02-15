//
//  ViewControllerPokedex.swift
//  TableViewTabBar
//
//  Created by dmorenoar on 22/12/18.
//  Copyright © 2018 DAM. All rights reserved.
//

import UIKit

class ViewControllerPokedex: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var arrayBreeds = breeds
    var tools:Tools = Tools()
    //Creamos la copia del array de razas
    var filterBreeds:[dogBreed] = [dogBreed]()
    //Defino el booleano que determina si el usuario esta buscando o no
    var isSearching:Bool = false
    
    let url = URL(string: "https://private-5ec35-pokemonswift.apiary-mock.com/pokemons")
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*print("Hay...",arrayBreeds.count)
        return arrayBreeds.count*/
        
        return !isSearching ? arrayBreeds.count : filterBreeds.count
    }
    
    var imagen:UIImage = UIImage()

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCellPokedex
        
        myCell.namePokemon.text = arrayBreeds[indexPath.row].name
        myCell.typePokemon.text = arrayBreeds[indexPath.row].country
 
        tools.getImage(imagenURL: arrayBreeds[indexPath.row].image) { (imgRecovered) -> Void in
            if let imagen = imgRecovered {
                DispatchQueue.main.async {
                    myCell.imgPokemon.image = imagen
                    return
                }
            }
        }
 
        myCell.typeImgPokemon.image = tools.getTypeImage(type: arrayBreeds[indexPath.row].country)

        return myCell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "Introduce película a buscar"
        decodeJsonData(url: url!)

    }
    
    
    func decodeJsonData(url:URL){
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                let decoder = JSONDecoder()

                self.arrayBreeds = try decoder.decode([dogBreed].self, from: data)
                print("recojo de api",self.arrayBreeds.count)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
        
        
      
    
        
    }
    
    //SEARCHBARCODE
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        /*REGEX*/
        
        /* FILTRADO SOLO POR EL PRINCIPIO DEL TÍTULO
         filterMovies = listMovies.filter({$0.title.prefix(searchText.count) == searchText})
         */
        
        //FILTRADO POR CUALQUIER CONTENIDO DEL TÍTULO
        //filterMovies = listMovies.filter({$0.title.lowercased().contains(searchText.lowercased())})
        
        filterBreeds = arrayBreeds.filter({ (dogBreed) -> Bool in
            return
        dogBreed.getName().lowercased().contains(searchText.lowercased())
        })
        
        
        /*
         //OPCION 1
         for m in listMovies {
         if m.title == searchText {
         filterMovies.append(m)
         }
         }
         */
         //OPCION 2
         filterBreeds = arrayBreeds.filter({ (dog:dogBreed) -> Bool in
         return dog.name.contains(searchText)
         })
         /*
         //OPCION 3
         arrayBreeds = list.filter({$0.title.contains(searchText)})
 */
        
        isSearching = searchText != "" ? true : false
        
        tableView.reloadData()
    }

}
