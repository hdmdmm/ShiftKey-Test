//
//  ShiftDescriptionView.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 28.11.22.
//

import SwiftUI

struct ShiftDescriptionView<VM: ShiftViewModelProtocol>: View {
  let viewModel: VM

  private var externalFrom: CGFloat {
    1/24.0 * CGFloat(viewModel.startHours)
  }
  private var externalTo: CGFloat {
    1/24.0 * CGFloat(viewModel.endHours < viewModel.startHours ? 24 : viewModel.endHours)
  }
  private var internalFrom: CGFloat {
    1/24.0 * CGFloat(viewModel.endHours < viewModel.startHours ? 0 : viewModel.startHours)
  }
  private var internalTo: CGFloat {
    1/24.0 * CGFloat(viewModel.endHours)
  }
  var body: some View {
    VStack {
      HStack {
        Image(systemName: "crown.fill")
          .resizable()
          .scaledToFit()
          .frame(width: 46.0, height: 46.0)
          .foregroundColor(viewModel.premiumRate ? Color.yellow : Color.gray)
      }
      
      Text(viewModel.facility.name)
        .font(.title)
        .font(.system(size: 300))
        .minimumScaleFactor(0.01)
        .foregroundColor(Color(hex: viewModel.facility.color))
        .frame(maxWidth: .infinity, minHeight: 24.0)
        .padding(.top, 20.0)
        .padding(.bottom, 20.0)
      
      VStack(spacing: 4.0) {
        Text(viewModel.workingDate)
          .font(.system(size: 32))
          .fontWeight(.medium)
        
        Text(viewModel.shiftKind)
          .font(.title3)
          .padding(.top, 2.0)
        
        Text("24")
          .padding(.bottom, 2.0)
        
        HStack {
          Text("18")
          Circle()
            .trim(from: externalFrom, to: externalTo)
            .stroke(lineWidth: 12.0)
            .rotation(Angle(degrees: -90.0))
            .foregroundColor(Color.orange.opacity(0.5))
            .background(
              Group {
                Circle()
                  .stroke(lineWidth: 12)
                  .foregroundColor(Color.gray.opacity(0.2))
                Circle()
                  .trim(from: internalFrom, to: internalTo)
                  .stroke(lineWidth: 12.0)
                  .rotation(Angle(degrees: -90.0))
                  .foregroundColor(Color.orange.opacity(0.5))
              }
            )
            .frame(width: 100.0, height: 100.0)
          Text("6")
        }
        Text("12")
          .padding(.top, 2.0)
        Text("Working hours: \(viewModel.workingHours)")
          .font(.title2)
      }
      .foregroundColor(Color(hex: viewModel.skill.color))
      
      Spacer(minLength: 10.0)

      VStack {
        Image(systemName: "staroflife")
          .resizable()
          .scaledToFit()
          .frame(maxWidth: 80.0, maxHeight: 80.0)

        Text(viewModel.speciality.abbreviation ?? "")
          .fontWeight(.heavy)
          .font(.system(size: 300))
          .minimumScaleFactor(0.01)
          .frame(maxWidth: .infinity, maxHeight: 200.0)
      }
      .padding(.top, 12.0)
      .foregroundColor(Color(hex: viewModel.speciality.color))

      Spacer()

      AttributesView(isCovid: viewModel.covid,
                     withinDistance: viewModel.withinDistance,
                     skillData: viewModel.skill)
      
    }
    .padding(12.0)
    .background(Color(hex: viewModel.facility.color)?.opacity(0.1))
  }
}

struct ShiftDescriptionView_Previews: PreviewProvider {
  @State var isPresented = true
  static let shared = ShiftDescriptionView_Previews()
  static var previews: some View {
//    EmptyView()
//      .sheet(isPresented: shared.$isPresented) {
        ShiftDescriptionView(
          viewModel: ShiftViewModel(model: shared.model)
        )
//      }
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
                        abbreviation: "CMA/CMT/QMA")))
  }
}
