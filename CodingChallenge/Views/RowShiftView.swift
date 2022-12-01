//
//  RowShiftView.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 27.11.22.
//

import SwiftUI
import Combine

struct RowShiftView<VM: ShiftViewModelProtocol>: View {
  var viewModel: VM
  
  var body: some View {
    HStack(spacing: 0) {
      Spacer()
      VStack(spacing: 8.0) {
        LicenseView(licenseData: viewModel.localizedSpeciality)

        FacilityTypeView(facilityData: viewModel.facility,
                         isPremium: viewModel.premiumRate)
        
        AttributesView(isCovid: viewModel.covid,
                       withinDistance: viewModel.withinDistance,
                       skillData: viewModel.skill)
      }

      Spacer()

      WorkingDayTimeView(viewModel: viewModel)

      Spacer()
    }
    .padding(.leading, 8)
    .padding(.trailing, 8)
    .background(Color(hex: viewModel.facility.color)?.opacity(0.1))
  }
}

struct RowShiftView_Previews: PreviewProvider {
  static var previews: some View {
    RowShiftView(viewModel: ShiftViewModel(model: RowShiftView_Previews().model))
  }
  
  var model: ShiftEntity {
    ShiftEntity(shiftID: 4636338,
                normalizedStartDateTime: "2022-11-27 14:00:00",
                normalizedEndDateTime: "2022-11-27 22:00:00",
                timezone: "Central",
                premiumRate: false,
                covid: false,
                shiftKind: "Evening Shift",
                withinDistance: 10,
                facilityType: FacilityType(name: "Skilled Nursing Facility",
                                           color: "#AF52DE",
                                           abbreviation: nil),
                skill: FacilityType(name: "Long Term Care",
                                    color: "#007AFF",
                                    abbreviation: nil),
                localizedSpeciality:
                  LocalizedSpeciality(
                    name: "Licensed Vocational Nurse",
                    abreviation: "LVN",
                    speciality:
                      FacilityType (
                        name: "Licensed Vocational/Practical Nurse",
                        color: "#AF52DE",
                        abbreviation: "LVN/LPN")))
  }
}
