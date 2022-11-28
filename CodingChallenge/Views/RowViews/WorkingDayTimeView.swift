//
//  WorkingDayTimeView.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 27.11.22.
//

import SwiftUI

struct WorkingDayTimeView: View {
  @ObservedObject var viewModel: ShiftViewModel
  private var shiftKind: String {
    viewModel.model.shiftKind
  }
  private var workingHours: String {
    viewModel.workingHours
  }
  private var workingDate: String {
    viewModel.workingDate
  }
  private var startHours: Int {
    viewModel.startHours
  }
  private var endHours: Int {
    viewModel.endHours
  }
  
  var body: some View {
    VStack {
      Text(viewModel.model.shiftKind)
        .font(.system(size: 13.0))
        .fontWeight(.light)
        .foregroundColor(Color.blue)
        .multilineTextAlignment(.center)
        .padding(.top, 8)
      
      Circle()
        .trim(from: 1/24.0 * CGFloat(startHours), to: 1/24.0 * CGFloat(endHours < startHours ? 24 : endHours))
        .rotation(.degrees(-90.0))
        .stroke(lineWidth: 6.0)
        .foregroundColor(Color.orange)
        .frame(width: 80.0, height: 80.0)
        .background(
          Group {
            Text(workingHours)
              .font(.system(size: 11.0))
              .fontWeight(.light)
              .foregroundColor(Color.green)
            
            Circle()
              .stroke(lineWidth: 6.0).foregroundColor(Color.blue.opacity(0.2))
            
            Circle()
              .trim(from: 1/24.0 * CGFloat(startHours > endHours ? 0 : startHours), to: 1/24.0 * CGFloat(endHours))
              .rotation(.degrees(-90.0))
              .stroke(lineWidth:  6.0)
              .foregroundColor(Color.orange)
          }
        )
      
      Text(workingDate)
        .font(.system(size: 13.0))
        .fontWeight(.light)
        .foregroundColor(Color.green)
        .multilineTextAlignment(.center)
        .padding(.bottom, 8)
    }
  }
}

struct WorkingDayTimeView_Previews: PreviewProvider {
  static var previews: some View {
    WorkingDayTimeView(viewModel: ShiftViewModel(model: WorkingDayTimeView_Previews().model))
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
