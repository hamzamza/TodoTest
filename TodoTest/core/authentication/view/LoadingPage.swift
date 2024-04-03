//
//  LoadingPage.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/3/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
    }
}
struct LoadingPage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
