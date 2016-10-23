//
//  ViewController.swift
//  pokedex-by-skipadu
//
//  Created by Sami Korpela on 16.4.2016.
//  Copyright © 2016 skipadu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var collection: UICollectionView!
  @IBOutlet weak var searchbar: UISearchBar!
  
  var pokemon = [Pokemon]()
  var musicPlayer: AVAudioPlayer!
  var isInSearchMode = false
  var filteredPokemon = [Pokemon]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collection.delegate = self
    collection.dataSource = self
    searchbar.delegate = self
    searchbar.returnKeyType = UIReturnKeyType.done
    
    initAudio()
    parsePokemonCSV()
  }
  
  func initAudio() {
    let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
    
    do {
      musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
      musicPlayer.prepareToPlay()
      musicPlayer.numberOfLoops = -1
      musicPlayer.play()
    } catch let err as NSError {
      print(err.debugDescription)
    }
    
  }
  
  func parsePokemonCSV() {
    let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
    
    do {
      let csv = try CSV(contentsOfURL: path)
      let rows = csv.rows
      
      for row in rows {
        let pokeId = Int(row["id"]!)!
        let name = row["identifier"]!
        let poke = Pokemon(name: name, pokedexId: pokeId)
        pokemon.append(poke)
      }
      
    } catch let err as NSError {
      print(err.debugDescription)
    }
    
  }
  
  @IBAction func musicButtonPressed(_ sender: UIButton) {
    if musicPlayer.isPlaying {
      musicPlayer.stop()
      sender.alpha = 0.5
    } else {
      musicPlayer.play()
      sender.alpha = 1.0
    }
  }
 
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "PokemonDetailVC" {
      if let detailsVC = segue.destination as? PokemonDetailVC {
        if let poke = sender as? Pokemon {
          detailsVC.pokemon = poke
        }
      }
    }
  }
  
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let poke: Pokemon!
    if isInSearchMode {
      poke = filteredPokemon[(indexPath as NSIndexPath).row]
    } else {
      poke = pokemon[(indexPath as NSIndexPath).row]
    }

    performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
  }
  
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
      
      let poke: Pokemon!
      if isInSearchMode {
        poke = filteredPokemon[(indexPath as NSIndexPath).row]
        
      } else {
        poke = pokemon[(indexPath as NSIndexPath).row]
      }
      cell.configureCell(poke)
      
      return cell
    } else {
      return UICollectionViewCell()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isInSearchMode {
      return filteredPokemon.count
    }
    return pokemon.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 105, height: 105)
  }
  
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchbar.isBlank() {
      isInSearchMode = false
      view.endEditing(true)
      collection.reloadData()
    } else {
      isInSearchMode = true
      let lower = searchbar.text!.lowercased()
      filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
      collection.reloadData()
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    view.endEditing(true)
  }
  
}
