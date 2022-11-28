//
//  FacilityTypeView.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 27.11.22.
//

import SwiftUI

struct FacilityTypeView: View {
  @State var facilityData: FacilityType
  @State var isPremium: Bool
  
  var body: some View {
    HStack {
      // facility type
      VStack {
        Text(facilityData.name)
          .font(.system(size: 17.0))
          .fontWeight(.regular)
          .padding(.top, 4.0)
      }
      
      // premium
      Image(systemName: "crown.fill")
        .resizable()
        .scaledToFit()
        .frame(width: 22, height: 22)
        .foregroundColor(isPremium ? Color.yellow : Color.gray)
        .padding(.top, 4)
      
      Spacer()
    }
    .foregroundColor(Color(hex: facilityData.color))
  }
}

struct FacilityTypeView_Previews: PreviewProvider {
  static var previews: some View {
    FacilityTypeView(facilityData: FacilityType(name: "Skilled Nursing Facility",
                                                color: "#AF52DE",
                                                abbreviation: nil),
                     isPremium: true)
  }
}
