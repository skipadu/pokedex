//
//  ExtensionsForUIComponents.swift
//  pokedex-by-skipadu
//
//  Created by Sami Korpela on 17.4.2016.
//  Copyright © 2016 skipadu. All rights reserved.
//

import UIKit

extension UISearchBar {
  
  /// Looks if the **UISearchBar.text** is nil or empty
  /// - returns: **Bool** -> is value of the **UISearchBar.text** nil or empty
  func isBlank() -> Bool {
    var result: Bool = false
    
    if text == nil || text == "" {
      result = true
    }
    return result
  }
  
}