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
  
  var pokemon = [Pokemon]()
  var musicPlayer: AVAudioPlayer!
  
  let pokemonCount: Int = 718
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collection.delegate = self
    collection.dataSource = self
    
    initAudio()
    parsePokemonCSV()
  }
  
  func initAudio() {
    let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
    
    do {
      musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
      musicPlayer.prepareToPlay()
      musicPlayer.numberOfLoops = -1
      musicPlayer.play()
    } catch let err as NSError {
      print(err.debugDescription)
    }
    
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
  
  @IBAction func musicButtonPressed(sender: UIButton) {
    if musicPlayer.playing {
      musicPlayer.stop()
      sender.alpha = 0.5
    } else {
      musicPlayer.play()
      sender.alpha = 1.0
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