//
//  Pokemon.swift
//  pokedex-by-skipadu
//
//  Created by Sami Korpela on 16.4.2016.
//  Copyright © 2016 skipadu. All rights reserved.
//

import Foundation

class Pokemon {
  private var _name: String!
  private var _pokeDexId: Int!
  private var _description: String!
  private var _type: String!
  private var _defense: String!
  private var _height: String!
  private var _weight: String!
  private var _attack: String!
  private var _nextEvolutionTxt: String!
  
  var name: String {
    return _name
  }
  
  var pokeDexId: Int {
    return _pokeDexId
  }
  
  init(name: String, pokedexId: Int) {
    self._name = name
    self._pokeDexId = pokedexId
  }
  
}