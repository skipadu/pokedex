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
  }
  
  @IBAction func backButtonPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
}
