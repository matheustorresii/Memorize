//
//  themes.swift
//  Memorize
//
//  Created by Matheus Torres on 19/08/20.
//  Copyright © 2020 Matheus Torres. All rights reserved.
//

import SwiftUI

struct Theme {
  let title: String
  let emojis: [String]
  let color: Color
}

let themeArray: [Theme] = [
  Theme(title: "Halloween", emojis: ["👻","🎃","🕷","☠️"], color: .orange),
  Theme(title: "Fruits", emojis: ["🍎","🍓","🍑","🍌","🍉","🍇"], color: .red),
  Theme(title: "Animals", emojis: ["🐸","🦁","🐷","🐼","🐨","🐹","🐶","🐱","🦊"], color: .green),
  Theme(title: "Flags", emojis: ["🇧🇷","🇸🇪","🇳🇱","🇰🇷","🇪🇸","🇯🇵","🇩🇪","🇵🇹","🇺🇸","🇯🇲","🇺🇳","🏳️‍🌈"], color: .blue),
  Theme(title: "Faces", emojis: ["😃","😂","🥰","🤩","😡","🤢","🤥","🤯","😱","😎","🥺","🥶","🤮","🤑","🤑","🤠","😷","🤪"], color: .yellow),
]
