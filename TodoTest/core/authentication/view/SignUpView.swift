//
//  SignUpView.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/2/24.
//

import Foundation
import SwiftUI
struct SignUpView : View  {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var repassword: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
    var body : some View {
        VStack( alignment  : .center ){
            Image("todo").resizable().scaledToFill().frame(width: 200, height: 200, alignment: .center)
                         VStack{
                InputView(text: $firstName, title: "First Name", placeholder: "Enter your first name")
                InputView(text: $lastName, title: "Last Name", placeholder: "Enter your last name")
                InputView(text: $email, title: "Email Address", placeholder: "Enter your email address")
                InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureFidld : true   )
                InputView(text: $repassword, title: "Confirm Password", placeholder: "Confirm your password" , isSecureFidld  : true)
            }
            Spacer().frame(height: 20)
            CustomButton(title: "create account " , backgroundColor: Color(.systemBlue), foregroundColor: .white){
                authViewModel.signUp(withEmail: email, withPassword: password, firstName: firstName, lastName: lastName, rememberMe : true ) { success   in
                    if success {
                       print("account created ")
                    }
                    else {
                        print("there is some error ")
                    }
                }

            }
            if let msg = authViewModel.errorMessage  {
                Text(msg)
            }
            Spacer()
            Button(
                action: {
                    authViewModel.errorMessage = nil
                    withAnimation(.easeInOut(duration:0.5)){
                        navigationViewModel.navigateBack( ) }
                },
                label: {
                    HStack{
                        Text("You Already Have One " ).fontWeight(.light).foregroundColor(.blue)
                        Text("Sign In").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                })
        }.padding(.top , 30).background(Color("background"))
    }
 }
 
struct SignUpPriview : PreviewProvider{
    static var previews: some View{
        SignUpView()
    }
}

