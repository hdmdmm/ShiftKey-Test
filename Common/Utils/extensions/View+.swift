////
////  View+.swift
////  CodingChallenge
////
////  Created by Dmitry Kh on 28.11.22.
////
//
//import SwiftUI
//
//struct LocalizedAlertError: LocalizedError {
//    let underlyingError: LocalizedError
//    var errorDescription: String? {
//        underlyingError.errorDescription
//    }
//    var recoverySuggestion: String? {
//        underlyingError.recoverySuggestion
//    }
//
//    init?(error: Error?) {
//        guard let localizedError = error as? LocalizedError else { return nil }
//        underlyingError = localizedError
//    }
//}
//
//extension View {
//  func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
//    let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
//    return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
//      Button(buttonTitle) {
//        error.wrappedValue = nil
//      }
//    } message: { error in
//      Text(error.recoverySuggestion ?? "")
//    }
//  }
//}
//
//struct View_: View {
//  var body: some View {
//    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//  }
//}
//
//struct View__Previews: PreviewProvider {
//  static var previews: some View {
//    View_()
//  }
//}
