//
//  PokemonDetailVC.swift
//  pokedex-by-skipadu
//
//  Created by Sami Korpela on 17.4.2016.
//  Copyright © 2016 skipadu. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
  @IBOutlet weak var nameLbl: UILabel!
  @IBOutlet weak var mainImg: UIImageView!
  @IBOutlet weak var descLbl: UILabel!
  @IBOutlet weak var typeLbl: UILabel!
  @IBOutlet weak var defenseLbl: UILabel!
  @IBOutlet weak var heightLbl: UILabel!
  @IBOutlet weak var pokedexIdLbl: UILabel!
  @IBOutlet weak var weightLbl: UILabel!
  @IBOutlet weak var baseAttackLbl: UILabel!
  
  @IBOutlet weak var evoLbl: UILabel!
  @IBOutlet weak var currentEvoImg: UIImageView!
  @IBOutlet weak var nextEvoImg: UIImageView!
  
  var pokemon: Pokemon!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nameLbl.text = pokemon.name.capitalized
    let img = UIImage(named: "\(pokemon.pokeDexId)")
    mainImg.image = img
    currentEvoImg.image = img
    
    pokemon.downloadPokemonDetails {
      self.updateUI()
    }
  }
  
  func updateUI() {
    descLbl.text = pokemon.description
    typeLbl.text = pokemon.type
    defenseLbl.text = pokemon.defense
    heightLbl.text = pokemon.height
    weightLbl.text = pokemon.weight
    pokedexIdLbl.text = "\(pokemon.pokeDexId)"
    baseAttackLbl.text = pokemon.attack
    
    if pokemon.nextEvolutionId == "" {
      evoLbl.text = "No evolutions"
      nextEvoImg.isHidden = true
    } else {
      nextEvoImg.isHidden = false
      nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
      var str = "Next evolution: \(pokemon.nextEvolutionTxt!)"
      
      if pokemon.nextEvolutionLvl != "" {
        str += " - LVL \(pokemon.nextEvolutionLvl)"
      }
      evoLbl.text = str
    }
    
  }
  
  @IBAction func backButtonPressed(_ sender: AnyObject) {
    dismiss(animated: true, completion: nil)
  }
  
}
