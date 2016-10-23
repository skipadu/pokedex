//
//  StringUtils.swift
//  pokedex-by-skipadu
//
//  Created by Sami Korpela on 17.4.2016.
//  Copyright © 2016 skipadu. All rights reserved.
//

import Foundation

func returnEmptyIfNil(_ string: String?) -> String {
  var result: String? = string
  if string == nil {
    result = ""
  }
  return result!
}
