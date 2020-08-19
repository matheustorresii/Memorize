//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Matheus Torres on 18/08/20.
//  Copyright © 2020 Matheus Torres. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  @ObservedObject var viewModel: EmojiMemoryGame
  var body: some View {
    Grid(viewModel.cards) { card in
      CardView(card: card)
        .onTapGesture {
          self.viewModel.choose(card: card)
      }
    .padding()
    }
    .foregroundColor(Color.orange)
    .padding()
  }
}

struct CardView: View {
  var card: MemoryGame<String>.Card
  
  var body: some View{
    GeometryReader { geometry in self.body(for: geometry.size) }
  }
  
  @ViewBuilder
  private func body(for size: CGSize) -> some View {
    if card.isFaceUp || !card.isMatched{
      ZStack {
        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(30)).padding(5).opacity(0.4)
        Text(card.content).font(Font.system(size: fontSize(for: size)))
      }
      .cardify(isFaceUp: card.isFaceUp)
    }
  }
  
  // MARK: - Drawing constants
  private let fontScaleFactor: CGFloat = 0.7
  
  func fontSize(for size: CGSize) -> CGFloat {
    min(size.width, size.height) * fontScaleFactor
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGame()
    game.choose(card: game.cards[1])
    return EmojiMemoryGameView(viewModel: game)
  }
}
