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
  fileprivate var _name: String!
  fileprivate var _pokedexId: Int!
  fileprivate var _description: String!
  fileprivate var _type: String!
  fileprivate var _defense: String!
  fileprivate var _height: String!
  fileprivate var _weight: String!
  fileprivate var _attack: String!
  fileprivate var _nextEvolutionTxt: String!
  fileprivate var _nextEvolutionId: String!
  fileprivate var _nextEvolutionLvl: String!
  
  fileprivate var _pokemonUrl: String!
  
  var name: String {
    return _name
  }
  
  var pokeDexId: Int {
    return _pokedexId!
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
    
    _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId!)/"
  }
  
  // TODO: Find out if there is some library that can "bind" JSON object straight to object?
  func downloadPokemonDetails(_ completed: @escaping DownloadComplete) {
    Alamofire.request(_pokemonUrl).responseJSON { response in
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
        
        if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
          if let typeName = types[0]["name"] {
            self._type = typeName.capitalized
          }
          if types.count > 1 {
            for x in 1 ..< types.count {
              if let typeName = types[x]["name"] {
                self._type! += "/\(typeName.capitalized)"
              }
            }
          }
        } else {
          self._type = ""
        }
        
        if let descArray = dict["descriptions"] as? [Dictionary<String, String>] , descArray.count > 0 {
          
          if let url = descArray[0]["resource_uri"] {
            let nsUrl = URL(string: "\(URL_BASE)\(url)")!
            Alamofire.request(nsUrl).responseJSON { response in
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
        
        if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
          
          if let to = evolutions[0]["to"] as? String {
            
            // MARK: Not supporting mega pokemons, atleast not yet
            if to.range(of: "mega") == nil {
              
              if let uri = evolutions[0]["resource_uri"] as? String {
                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                let num = newStr.replacingOccurrences(of: "/", with: "")
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
