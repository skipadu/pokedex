//
//  ViewController.swift
//  pokedex-by-skipadu
//
//  Created by Sami Korpela on 16.4.2016.
//  Copyright © 2016 skipadu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var collection: UICollectionView!
  
  var pokemon = [Pokemon]()
  
  let pokemonCount: Int = 718
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collection.delegate = self
    collection.dataSource = self
    
    parsePokemonCSV()
  }
  
  func parsePokemonCSV() {
    let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
    
    do {
      let csv = try CSV(contentsOfURL: path)
      let rows = csv.rows
      
      for row in rows {
        let pokeId = Int(row["id"]!)!
        let name = row["identifier"]!
        let poke = Pokemon(name: name, pokedexId: pokeId)
        pokemon.append(poke)
      }
      
      print(rows)
    } catch let err as NSError {
      print(err.debugDescription)
    }
    
  }
  
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
  }
  
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
      
      let poke = pokemon[indexPath.row]
      cell.configureCell(poke)
      
      return cell
    } else {
      return UICollectionViewCell()
    }
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pokemonCount
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(105, 105)
  }
  
}