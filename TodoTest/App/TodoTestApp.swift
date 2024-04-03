//
//  TodoTestApp.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/2/24.
//

import SwiftUI
import Firebase
@main
struct TodoTestApp: App {
    init() {
        FirebaseApp.configure()
    }
    let navigationViewModel = NavigationViewModel()
    let authViewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color("background").ignoresSafeArea()
                ContentView()
                    .environmentObject(navigationViewModel)
                    .environmentObject(authViewModel)
            }
        }
    }
}
