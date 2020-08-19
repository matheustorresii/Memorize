//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Matheus Torres on 18/08/20.
//  Copyright © 2020 Matheus Torres. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
  func firstIndex(matching: Element) -> Int?{
    for index in 0..<self.count {
      if self[index].id == matching.id{
        return index
      }
    }
    return nil
  }
}
