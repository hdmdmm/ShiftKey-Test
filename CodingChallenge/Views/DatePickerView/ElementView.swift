//
//  ElementView.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 25.11.22.
//

import SwiftUI

struct ElementView: View, Identifiable {
  @Binding var selectedIndex: Int
  var id: Int
  var title: String
  
  var body: some View {
    Text(title)
      .font(.title)
      .foregroundColor(selectedIndex == id ? .red : .black)
  }
}

struct ElementView_Previews: PreviewProvider {
  @State var selectedIndex = 0
  static var previews: some View {
    ElementView(selectedIndex: ElementView_Previews().$selectedIndex,
                id: 0,
                title: "Go Go Go!")
  }
}
