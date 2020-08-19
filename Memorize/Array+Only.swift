//
//  Array+Only.swift
//  Memorize
//
//  Created by Matheus Torres on 18/08/20.
//  Copyright © 2020 Matheus Torres. All rights reserved.
//

import Foundation

extension Array {
  var only: Element? {
    count == 1 ? first : nil
  }
}
