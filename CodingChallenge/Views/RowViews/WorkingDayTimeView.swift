//
//  WorkingDayTimeView.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 27.11.22.
//

import SwiftUI

struct WorkingDayTimeView: View {
  @State var shiftKind: String
  @State var workingHours: String
  @State var workingDate: String
  @State var startHour: Int
  @State var endHour: Int
  
  var body: some View {
    VStack {
      Text(shiftKind)
        .font(.system(size: 13.0))
        .fontWeight(.light)
        .foregroundColor(Color.blue)
        .multilineTextAlignment(.center)
        .padding(.top, 8)
      
      Circle()
        .trim(from: 1/24.0 * CGFloat(startHour), to: 1/24.0 * CGFloat(endHour < startHour ? 24 : endHour))
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
              .trim(from: 1/24.0 * CGFloat(startHour > endHour ? 0 : startHour), to: 1/24.0 * CGFloat(endHour))
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
    WorkingDayTimeView(
      shiftKind: "Evening Shift",
      workingHours: "18:00 - 6:00",
      workingDate: "2022-11-27",
      startHour: 18,
      endHour: 1
    )
  }
}
