//
//  MemoryGame.swift
//  Memorize
//
//  Created by Matheus Torres on 18/08/20.
//  Copyright © 2020 Matheus Torres. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  private(set) var cards: Array<Card>
  
  private var indexOfTheOneAndOnlyFaceUpCard: Int?{
    get { cards.indices.filter { cards[$0].isFaceUp }.only }
    set {
      for index in cards.indices {
          cards[index].isFaceUp = index == newValue
      }
    }
  }
  
  mutating func choose(card: Card){
    if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
      if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
        if cards[chosenIndex].content == cards[potentialMatchIndex].content{
          cards[chosenIndex].isMatched = true
          cards[potentialMatchIndex].isMatched = true
        }
        self.cards[chosenIndex].isFaceUp = true
      }else{
        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
      }
    }
  }
  
  init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
    cards = Array<Card>()
    for pairIndex in  0..<numberOfPairsOfCards {
      let content = cardContentFactory(pairIndex)
      cards.append(Card(id: pairIndex*2, content: content))
      cards.append(Card(id: pairIndex*2+1, content: content))
    }
    cards.shuffle()
  }
  
  struct Card: Identifiable {
    var id: Int
    var isFaceUp: Bool = false {
      didSet {
        if isFaceUp {
          startUsingBonusTime()
        }else{
          stopUsingBonusTime()
        }
      }
    }
    var isMatched: Bool = false
    var content: CardContent
    
    
    
    
    
    
    
    
    
    
    //MARK: - Bonus Time
    
//    this could give matching bonus points
//    if the user mathes the card before a certain amount of time passes during which the card is face up
    
//    can be zero which means "no bonus available" for this card
    var bonusTimeLimit: TimeInterval = 6
    
//    how long this card has ever been face up
    private var faceUpTime: TimeInterval {
      if let lastFaceUpDate = self.lastFaceUpdate {
        return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
      }else{
        return pastFaceUpTime
      }
    }
    
//    the last time this card was turned face up (and is still face up)
    var lastFaceUpdate: Date?
    
//    the accumulated time this card has been face up in the bast
//    (i.e. not including the current time it's been face up if it is currently so)
    var pastFaceUpTime: TimeInterval = 0
    
//    how much time left before the bonus opportunity runs out
    var bonusTimeRemaining: TimeInterval {
      max(0, bonusTimeLimit - faceUpTime)
    }
    
//    percentage of the bonus time remaining
    var bonusRemaining: Double {
      (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
    }
    
//    wheter the card was matched during the bonus time period
    var hasEarnedBonus: Bool{
      isMatched && bonusTimeRemaining > 0
    }
    
//    whether we are currently face up, unmatched and have not yet used up the bonus window
    var isConsumingBonusTime: Bool {
      isFaceUp && !isMatched && bonusTimeRemaining > 0
    }
    
//    called when the card transitions to face up state
    private mutating func startUsingBonusTime(){
      if isConsumingBonusTime, lastFaceUpdate == nil {
        lastFaceUpdate = Date()
      }
    }
    
//    called when the card goes back face down (or gets matched)
    private mutating func stopUsingBonusTime(){
      pastFaceUpTime = faceUpTime
      self.lastFaceUpdate = nil
    }
  }
}
