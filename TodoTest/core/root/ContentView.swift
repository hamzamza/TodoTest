//
//  ContentView.swift
//  Todoz
//
//  Created by Hamza Douaij on 4/2/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    var body: some View {
        switch navigationViewModel.currentScreen {
            case .login:
                LoginView()
            case .signIn:
                SignUpView()
            case .home:
                LoginView()
            case .details:
                LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
