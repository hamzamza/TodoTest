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
    let navigationViewModel = NavigationController()
    let authViewModel = AuthViewModel()
    let taskListViewModel  = TaskListViewModel()
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .environmentObject(navigationViewModel)
                    .environmentObject(authViewModel)
                    .environmentObject(taskListViewModel )
            }
        }
    }
}
