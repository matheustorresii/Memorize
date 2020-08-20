//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Matheus Torres on 18/08/20.
//  Copyright © 2020 Matheus Torres. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  var body: some View {
    NavigationView{
      List(themeArray, id: \.title){ theme in
        NavigationLink(destination: ThemeProvider(chosenTheme: theme)){
          VStack(alignment: .leading){
            Text("\(theme.title)")
              .foregroundColor(theme.color)
              .font(Font.system(size: 35))
            HStack{
              ForEach(0..<theme.emojis.count){emoji in
                Text("\(theme.emojis[emoji])")
                .font(Font.system(size: 25))
              }
            }
          }
        }
      }
      .navigationBarTitle("Themes")
    }
  }
}

struct ThemeProvider: View {
  var chosenTheme: Theme
  var body: some View {
    GameView(viewModel: EmojiMemoryGame(EmojiMemoryGame.createMemoryGame(chosenEmojisArray: chosenTheme.emojis),emojisArray: chosenTheme.emojis), theme: chosenTheme)
      .navigationBarTitle(Text(chosenTheme.title), displayMode: .inline)
  }
}

struct GameView: View {
  @ObservedObject var viewModel: EmojiMemoryGame
  var theme: Theme
  var body: some View {
    VStack{
      Grid(viewModel.cards) { card in
        CardView(card: card).onTapGesture {
          withAnimation(.linear){
            self.viewModel.choose(card: card)
          }
        }
        .padding()
      }
      .foregroundColor(theme.color)
      .padding()
    }
    .navigationBarItems(trailing:
      Button(action:{withAnimation(.easeInOut){self.viewModel.resetGame()}},label:{ Text("New game") })
    )
  }
}

struct CardView: View {
  var card: MemoryGame<String>.Card
  
  var body: some View{
    GeometryReader { geometry in self.body(for: geometry.size) }
  }
  
  @State private var animatedBonusRemaining: Double = 0
  
  private func startBonusTimeAnimation(){
    animatedBonusRemaining = card.bonusRemaining
    withAnimation(.linear(duration: card.bonusTimeRemaining)) {
      animatedBonusRemaining = 0
    }
  }
  
  @ViewBuilder
  private func body(for size: CGSize) -> some View {
    if card.isFaceUp || !card.isMatched{
      ZStack {
        Group{
          if card.isConsumingBonusTime {
            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90))
            .onAppear{
              self.startBonusTimeAnimation()
            }
          }else{
            Pie(startAngle: Angle.degrees(-90),endAngle: Angle.degrees(-card.bonusRemaining*360-90))
          }
        }
        .padding(5)
        .opacity(0.4)
        .transition(.identity)
        Text(card.content)
          .font(Font.system(size: fontSize(for: size)))
          .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
          .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
      }
      .cardify(isFaceUp: card.isFaceUp)
      .transition(AnyTransition.scale)
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
    EmojiMemoryGameView()
  }
}
