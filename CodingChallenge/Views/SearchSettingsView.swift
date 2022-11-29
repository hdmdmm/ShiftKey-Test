//
//  SearchSettingsView.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 29.11.22.
//

import SwiftUI
import Combine

struct SearchSettingsView: View {
  var viewModel: SearchSettingsViewModel
  var body: some View {
    
    NavigationView {
      List {
        HStack {
          Text("Address: ")
          Spacer()
          Text("\(viewModel.address)")
        }

        HStack {
          Text("Type: ")
          Spacer()
          Text("\(viewModel.type.rawValue)")
        }

        HStack {
          Text("From date: ")
          Spacer()
          Text("\(viewModel.startDate)")
        }

        HStack {
          Text("To date: ")
          Spacer()
          Text("\(viewModel.endDate)")
        }

        HStack {
          Text("Distance: ")
          Spacer()
          Text(String(format:"%.2f", viewModel.distance))
        }
      }
      .navigationTitle("Search Settings")
    }
  }
}

struct SearchSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SearchSettingsView(viewModel: SearchSettingsViewModel())
  }
}
