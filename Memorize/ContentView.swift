//
//  ContentView.swift
//  Memorize
//
//  Created by Matheus Torres on 18/08/20.
//  Copyright © 2020 Matheus Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var viewModel: EmojiMemoryGame
  var body: some View {
    HStack {
      ForEach (viewModel.cards) { card in
        CardView(card: card)
          .onTapGesture {
            self.viewModel.choose(card: card)
        }
      }
    }
    .foregroundColor(Color.orange)
    .padding()
    .font(Font.largeTitle)
  }
}

struct CardView: View {
  var card: MemoryGame<String>.Card
  var body: some View{
    ZStack {
      if card.isFaceUp{
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.white)
        RoundedRectangle(cornerRadius: 10)
          .stroke(lineWidth: 3)
        Text(card.content)
      } else {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.orange)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(viewModel: EmojiMemoryGame())
  }
}
