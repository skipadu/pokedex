//
//  Pokemon.swift
//  pokedex-by-skipadu
//
//  Created by Sami Korpela on 16.4.2016.
//  Copyright © 2016 skipadu. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
  private var _name: String!
  private var _pokedexId: Int!
  private var _description: String!
  private var _type: String!
  private var _defense: String!
  private var _height: String!
  private var _weight: String!
  private var _attack: String!
  private var _nextEvolutionTxt: String!
  private var _nextEvolutionId: String!
  private var _nextEvolutionLvl: String!
  
  private var _pokemonUrl: String!
  
  var name: String {
    return _name
  }
  
  var pokeDexId: Int {
    return _pokedexId
  }
  
  var description: String {
    return returnEmptyIfNil(_description)
  }
  
  var type: String! {
    return returnEmptyIfNil(_type)
  }
  
  var defense: String {
    return returnEmptyIfNil(_defense)
  }
  
  var height: String {
    return returnEmptyIfNil(_height)
  }
  
  var weight: String {
    return returnEmptyIfNil(_weight)
  }
  
  var attack: String {
    return returnEmptyIfNil(_attack)
  }
  
  var nextEvolutionTxt: String! {
    return returnEmptyIfNil( _nextEvolutionTxt)
  }
  
  var nextEvolutionId: String {
    return returnEmptyIfNil(_nextEvolutionId)
  }
  
  var nextEvolutionLvl: String {
    return returnEmptyIfNil(_nextEvolutionLvl)
  }
  
  init(name: String, pokedexId: Int) {
    self._name = name
    self._pokedexId = pokedexId
    
    _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
  }
  
  func downloadPokemonDetails(completed: DownloadComplete) {
    let url = NSURL(string: _pokemonUrl)!
    Alamofire.request(.GET, url).responseJSON { response in
      let result = response.result
      
      if let dict = result.value as? Dictionary<String, AnyObject> {
        
        if let weight = dict["weight"] as? String {
          self._weight = weight
        }
        if let height = dict["height"] as? String {
          self._height = height
        }
        if let attack = dict["attack"] as? Int {
          self._attack = "\(attack)"
        }
        if let defense = dict["defense"] as? Int {
          self._defense = "\(defense)"
        }
        
        if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
          if let typeName = types[0]["name"] {
            self._type = typeName.capitalizedString
          }
          if types.count > 1 {
            for x in 1 ..< types.count {
              if let typeName = types[x]["name"] {
                self._type! += "/\(typeName.capitalizedString)"
              }
            }
          }
        } else {
          self._type = ""
        }
        
        if let descArray = dict["descriptions"] as? [Dictionary<String, String>] where descArray.count > 0 {
          
          if let url = descArray[0]["resource_uri"] {
            let nsUrl = NSURL(string: "\(URL_BASE)\(url)")!
            Alamofire.request(.GET, nsUrl).responseJSON { response in
              let descResult = response.result
              if let descDict = descResult.value as? Dictionary<String, AnyObject> {
                if let description = descDict["description"] as? String {
                  self._description = description
                }
              }
              completed()
            }
          }
        } else {
          self._description = ""
        }
        
        if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
          
          if let to = evolutions[0]["to"] as? String {
            
            // MARK: Not supporting mega pokemons, atleast not yet
            if to.rangeOfString("mega") == nil {
              
              if let uri = evolutions[0]["resource_uri"] as? String {
                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                self._nextEvolutionId = num
                self._nextEvolutionTxt = to
                
                if let lvl = evolutions[0]["level"] as? Int {
                  self._nextEvolutionLvl = "\(lvl)"
                }
              }
              
            }
          }
          
        }
      }
    }
  }
  
}