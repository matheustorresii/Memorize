//
//  ContentView.swift
//  Memorize
//
//  Created by Matheus Torres on 18/08/20.
//  Copyright © 2020 Matheus Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    HStack {
      ForEach (0..<4) { index in CardView(isFaceUp: true) }
    }
    .foregroundColor(Color.orange)
    .padding()
    .font(Font.largeTitle)
  }
}

struct CardView: View {
  var isFaceUp: Bool
  var body: some View{
    ZStack {
      if isFaceUp{
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.white)
        RoundedRectangle(cornerRadius: 10)
          .stroke(lineWidth: 3)
        Text("👻")
      } else {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.orange)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
