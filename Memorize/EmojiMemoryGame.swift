//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Matheus Torres on 18/08/20.
//  Copyright © 2020 Matheus Torres. All rights reserved.
//

import SwiftUI

//func createCardContent(pairIndex: Int) -> String {
//  return "🐸"
//}

class EmojiMemoryGame: ObservableObject {
  @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
  
  private static func createMemoryGame() -> MemoryGame<String> {
    let emojis: Array<String> = ["👻","🎃","🕷","☠️","🧟","🧛‍♂️"]
    return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in emojis[pairIndex] }
  }
  
  // MARK: - Access to the model
  
  var cards: Array<MemoryGame<String>.Card> {
    model.cards
  }
  
  // MARK: - Intent(s)
  
  func choose(card: MemoryGame<String>.Card){
    objectWillChange.send()
    model.choose(card: card)
  }
  
  func resetGame(){
    model = EmojiMemoryGame.createMemoryGame()
  }
}
