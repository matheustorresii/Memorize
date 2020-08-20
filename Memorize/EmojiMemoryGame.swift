//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Matheus Torres on 18/08/20.
//  Copyright © 2020 Matheus Torres. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  @Published private var model: MemoryGame<String>
  var emojisArray: [String]
  
  init(_ model: MemoryGame<String>, emojisArray: [String]) {
    self.model = model
    self.emojisArray = emojisArray
  }

  static func createMemoryGame(chosenEmojisArray:[String]) -> MemoryGame<String> {
    return MemoryGame<String>(numberOfPairsOfCards: chosenEmojisArray.count) { pairIndex in chosenEmojisArray[pairIndex] }
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
    model = EmojiMemoryGame.createMemoryGame(chosenEmojisArray: emojisArray)
  }
}
