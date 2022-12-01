//
//  SearchSettingsView.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 29.11.22.
//

import SwiftUI
import Combine

struct SearchSettingsView: View {
  @Binding var model: ShiftsRequestEntity

  var body: some View {
    
    NavigationView {
      List {
        HStack {
          Text("Address: ")
          Spacer()
          Text("\(model.address)")
        }

        HStack {
          Text("Type: ")
          Spacer()
          Text(model.type?.rawValue ?? "")
        }

        HStack {
          Text("From date: ")
          Spacer()
          Text(model.start ?? "")
        }

        HStack {
          Text("To date: ")
          Spacer()
          Text(model.end ?? "")
        }

        HStack {
          Text("Distance: ")
          Spacer()
          Text(String(format:"%.2f", model.radius ?? .infinity))
        }
      }
      .navigationTitle("Search Settings")
    }
  }
}

struct SearchSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SearchSettingsView(model: SearchSettingsView_Previews().$model)
  }
  
  @State var model = ShiftsRequestEntity(address: "Dallas, TX", type: nil, start: nil, end: nil, radius: 15.8)
}
