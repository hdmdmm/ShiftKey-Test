//
//  LicenseView.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 27.11.22.
//

import SwiftUI

struct LicenseView: View {
  @State var licenseData: LocalizedSpeciality
  
  var body: some View {
    HStack(spacing: 0) {
      //license Abreviation
      Image(systemName: "staroflife")
        .resizable()
        .scaledToFit()
        .frame(width: 28.0, height: 28.0)
        .padding(.trailing)
      
      VStack(spacing: 0) {
        Text(licenseData.speciality.abbreviation ?? licenseData.name)
          .font(.system(size: 28.0))
          .fontWeight(.heavy)
      }
      
      Spacer()
    }
    .foregroundColor(Color(hex: licenseData.speciality.color))
  }
}

struct LicenseView_Previews: PreviewProvider {
  static var previews: some View {
    LicenseView(licenseData: LocalizedSpeciality(
      name: "Licensed Vocational Nurse",
      abreviation: "LVN",
      speciality:
        FacilityType (
          name: "Licensed Vocational/Practical Nurse",
          color: "#AF52DE",
          abbreviation: "LVN/LPN"))
    )
  }
}
