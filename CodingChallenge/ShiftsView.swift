//
//  ShiftsView.swift
//  CodingChallenge
//
//  Created by Brady Miller on 4/7/21.
//

import SwiftUI
import Combine

struct ShiftsView: View {
  @ObservedObject var viewModel: ShiftsViewModel
  @State private var selectedViewModel: ShiftViewModel?
  
  var body: some View {
    NavigationView {
      Group {
        ZStack {
          
          VStack {
            // Date selector
            DatePickerView(selectedIndex: $viewModel.selectedIndex, list: $viewModel.dates)
              .background(Color.gray.opacity(0.2))
              .frame(maxWidth: .infinity, maxHeight: 56.0)
            
            List {
              ForEach($viewModel.list) { $viewModel in
                Button {
                  selectedViewModel = $viewModel.wrappedValue
                } label: {
                  RowShiftView(viewModel: $viewModel.wrappedValue)
                    .frame( maxWidth: .infinity )
                    .edgesIgnoringSafeArea(.all)
                }
              }
            }// presents detailed view modally
            .sheet(item: $selectedViewModel) {
              ShiftDescriptionView(viewModel: $0)
            }
            .frame( maxWidth: .infinity)
            .edgesIgnoringSafeArea(.all)
            .listStyle(PlainListStyle())
          }
          
          // Buttons
          HStack {
            Spacer()
            VStack {
              Spacer()
              Group {
                Button {} label: { Image(systemName: "gearshape.2") }
                Button { viewModel.doSearch() } label: { Image(systemName: "magnifyingglass") }
              }
              .font(.title)
              .frame(width: 52.0, height: 52.0, alignment: .center)
              .background(Color.white.opacity(0.7))
              .cornerRadius(26.0)
              .shadow(radius: 26.0)
              .shadow(color: Color.white, radius: 32.0, x: 2.0, y: 2.0)
              .padding(.trailing, 16.0)
              .padding(.bottom, 16.0)
            }
          }
        }
        .frame(maxWidth: .infinity)
      }
      .navigationTitle("Shifts")
      .alert(item: $viewModel.errorInfo) { error in
        Alert(title: Text(error.title), message: Text(error.description))
      }
    }
    .allowsHitTesting(!($viewModel.isSearching.wrappedValue))
    .onAppear { viewModel.doSearch() }
    .overlay( ActivityIndicator(isAnimating: $viewModel.isSearching, style: .large) )
  }
}

struct ShiftsView_Previews: PreviewProvider {
  static var previews: some View {
    ShiftsView(viewModel: ShiftsViewModel(fetchShiftsUseCase: PreviewUseCase()))
  }
}

struct PreviewUseCase: FetchShiftsUseCaseProtocol {
  func searchShifts(by: ShiftsRequestEntity) -> AnyPublisher<[String : [ShiftEntity]], Error> {
    Just(
      ["2022-11-27":
        [
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
                            FacilityType(
                              name: "Licensed Vocational/Practical Nurse",
                              color: "#AF52DE",
                              abbreviation: "LVN/LPN")))
        ],
       "2022-11-28":
        [
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
                            FacilityType(
                              name: "Licensed Vocational/Practical Nurse",
                              color: "#AF52DE",
                              abbreviation: "LVN/LPN")))
        ],
       "2022-11-29":
        [
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
                            FacilityType(
                              name: "Licensed Vocational/Practical Nurse",
                              color: "#AF52DE",
                              abbreviation: "LVN/LPN")))
        ],
       "2022-11-30":
        [
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
                            FacilityType(
                              name: "Licensed Vocational/Practical Nurse",
                              color: "#AF52DE",
                              abbreviation: "LVN/LPN")))
        ],
       "2022-12-01":
        [
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
                            FacilityType(
                              name: "Licensed Vocational/Practical Nurse",
                              color: "#AF52DE",
                              abbreviation: "LVN/LPN")))
        ],
       "2022-12-02":
        [
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
                            FacilityType(
                              name: "Licensed Vocational/Practical Nurse",
                              color: "#AF52DE",
                              abbreviation: "LVN/LPN")))
        ]
      ])
    .setFailureType(to: Error.self)
    .eraseToAnyPublisher()
  }
}
