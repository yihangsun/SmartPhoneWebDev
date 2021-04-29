//
//  PokemonViewController.swift
//  PokemonApp
//
//  Created by Yihang Sun on 4/23/21.
//

import UIKit
import FirebaseDatabase
import Alamofire
import SwiftSpinner
import SwiftyJSON
import PromiseKit
import AlamofireImage

class PokemonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tblPokemons: UITableView!
    
    @IBOutlet weak var lblPokeName: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblAbility: UILabel!
    @IBOutlet weak var imgPokemon: UIImageView!
    
    var pokeData : [ModelPokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblPokemons.delegate = self
        self.tblPokemons.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPokeData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokeData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell

        if self.pokeData.count > 0  {
            cell.lblPokemon?.text = "\(self.pokeData[indexPath.row].name)"
            if URL(string: "\(self.pokeData[indexPath.row].picURL)") == nil {
                print("\(self.pokeData[indexPath.row].name) Contains Nill Pic")
            } else {
                let downloader = ImageDownloader()
                let urlRequest = URLRequest(url: URL(string: "\(self.pokeData[indexPath.row].picURL)")!)
                downloader.download(urlRequest, completion:  { response in
                    if case .success(let image) = response.result {
                        cell.imgPokemon?.image = image
                    }
                })
            }
            
            cell.buttonPressed = {
                self.lblPokeName.text = "\(self.pokeData[indexPath.row].name.uppercased())"
                self.lblHeight.text = "Height: \(self.pokeData[indexPath.row].height) decimetres"
                self.lblWeight.text = "Weight: \(self.pokeData[indexPath.row].weight)  hectograms"
                self.lblAbility.text = "Ability: \(self.pokeData[indexPath.row].ability)"
                if URL(string: "\(self.pokeData[indexPath.row].picURL)") == nil {
                    print("Contain Nill Pic")
                } else {
                    let downloader = ImageDownloader()
                    let urlRequest = URLRequest(url: URL(string: "\(self.pokeData[indexPath.row].picURL)")!)
                    downloader.download(urlRequest, completion:  { response in
                        if case .success(let image) = response.result {
                            self.imgPokemon.image = image
                        }
                    })
                }
            }
        }
        
        return cell
    }
    
    func getPokeData() {
        AF.request(pokemonsAPI).responseJSON { response in
            if response.error == nil {
                print(pokemonsAPI)
                guard response.data != nil else { return }
                let pokeJSON : JSON = JSON(response.data as Any)
                    for eachPoke in pokeJSON["results"].arrayValue {
                        let pokeModel : ModelPokemon = ModelPokemon("", "", 0, 0, "")
                        pokeModel.name = eachPoke["name"].stringValue.capitalized
                        let pokeInfoAPI = eachPoke["url"].stringValue
                        AF.request(pokeInfoAPI).responseJSON { response in
                            if response.error == nil {
                                guard response.data != nil else { return }
                                let pokeInfoJSON : JSON = JSON(response.data as Any)
                                pokeModel.ability = pokeInfoJSON["abilities"][0]["ability"]["name"].stringValue.capitalized
                                pokeModel.height = pokeInfoJSON["height"].intValue
                                pokeModel.weight = pokeInfoJSON["weight"].intValue
                                pokeModel.picURL = pokeInfoJSON["sprites"]["front_default"].stringValue
                            }
                        }
                        self.pokeData.append(pokeModel)
                    }
                self.tblPokemons.reloadData()
            }
        }
    }
}

