//
//  AttributesView.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 27.11.22.
//

import SwiftUI

struct AttributesView: View {
  @State var isCovid: Bool
  @State var withinDistance: Int
  @State var skillData: FacilityType
  
  var body: some View {
    HStack(spacing: 12) {
      VStack(spacing: 0) {
        Image(systemName: "figure.walk")
          .resizable()
          .scaledToFit()
          .frame(width: 24.0, height: 24.0)
          .padding(.trailing)
        
        Text("\(withinDistance) miles")
          .font(.system(size: 12.0))
          .fontWeight(.light)
      }
      .foregroundColor(Color.purple)
      
      VStack(spacing: 0) {
        // Corona
        Image(systemName: "timelapse")
          .resizable()
          .scaledToFit()
          .frame(width: 24.0, height: 24.0)
        
        Text("Corona".localized)
          .font(.system(size: 12.0))
          .fontWeight(.light)
      }
      .foregroundColor(isCovid ? Color.pink : Color.gray)
      
      VStack(spacing: 0) {
        // Long term care
        Image(systemName: "person.badge.clock.fill")
          .resizable()
          .scaledToFit()
          .frame(width: 24.0, height: 24.0)
          .padding(.trailing)
        Text(skillData.name)
          .font(.system(size: 10.0))
          .fontWeight(.light)
      }
      .foregroundColor(Color(hex: skillData.color))
    }
  }
}

struct AttributesView_Previews: PreviewProvider {
  static var previews: some View {
    AttributesView(isCovid: false,
                   withinDistance: 20,
                   skillData: FacilityType(name: "Long Term Care",
                                           color: "#007AFF",
                                           abbreviation: nil))
  }
}
