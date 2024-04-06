//
//  SignUpView.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/2/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Image("todolistblackwhite")
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height/3)
                .padding(.bottom, 20)
            
            VStack {
                InputView(text: $email, title: "Email Address", placeholder: "example@sqli.com")
                InputView(text: $password, title: "Password", placeholder: "example password", isSecureFidld: true)
                
                Toggle("Remember me", isOn: $rememberMe)
                    .padding(.vertical)
            }
            
            CustomButton(title: "Sign In", backgroundColor: Color.white, foregroundColor: .black) {
                authViewModel.signIn(withEmail: email, withPassword: password, rememberMe: rememberMe) { isLogedIn in
                    if isLogedIn {
                        navigationController.navigateTo(screen: .tasklist)
                    } else {
                        print("not logged in")
                    }
                }
            }
            
            if let msg = authViewModel.errorMessage {
                Spacer().frame(height: 40)
                ErrorCardView(errorMessage: msg, actionTitle: "Error") {
                    authViewModel.errorMessage = nil
                }
            }
            
            Spacer()
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    authViewModel.errorMessage = nil
                    navigationController.navigateTo(screen: .signUp)
                }
            }) {
                HStack {
                    Text("Don't have an account").fontWeight(.light).foregroundColor(.blue)
                    Text("Sign up").fontWeight(.bold)
                }
            }
        }
        .padding(10)
        .navigationBarHidden(true)
    }
}

struct LoginPriview: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
