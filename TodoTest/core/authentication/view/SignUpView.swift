//
//  SignUpView.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/2/24.
//
import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var repassword = ""
    @State private var firstName = ""
    @State private var lastName = ""
    
    @EnvironmentObject var navigationViewModel: NavigationController
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Image("todolistblackwhite")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
            
            VStack(spacing: 20) {
                InputView(text: $firstName, title: "First Name", placeholder: "Enter your first name")
                InputView(text: $lastName, title: "Last Name", placeholder: "Enter your last name")
                InputView(text: $email, title: "Email Address", placeholder: "Enter your email address")
                InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureFidld: true)
                InputView(text: $repassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureFidld: true)
            }
            .padding(.top, 20)
            
            CustomButton(title: "Create Account", backgroundColor: .white, foregroundColor: .black) {
                authViewModel.signUp(withEmail: email, withPassword: password, firstName: firstName, lastName: lastName, rememberMe: true) { success in
                    if success {
                        print("Account created")
                    } else {
                        print("There is some error")
                    }
                }
            }
            
            if let errorMessage = authViewModel.errorMessage {
                Spacer().frame(height: 40)
                ErrorCardView(errorMessage: errorMessage, actionTitle: "Error") {
                    authViewModel.errorMessage = nil
                }
            }
            
            Spacer()
            
            Button(action: {
                authViewModel.errorMessage = nil
                withAnimation(.easeInOut(duration: 0.5)) {
                    navigationViewModel.navigateBack()
                }
            }) {
                HStack {
                    Text("Already have an account").fontWeight(.light).foregroundColor(.blue)
                    Text("Sign In").fontWeight(.bold)
                }
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 20)
    }
}

struct SignUpPriview: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
