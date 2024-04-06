//
//  LoginView.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/2/24.
//

import Foundation
import SwiftUI
struct LoginView : View  {
    @State private var email  = ""
    @State private var password = ""
    @EnvironmentObject var navigationViewModel: NavigationController
    @EnvironmentObject var authViewModel : AuthViewModel
    var body : some View {
         
        VStack {
            Image("todolistblackwhite").resizable().scaledToFill().frame(  height :   UIScreen.main.bounds.height/3,   alignment: .center).padding(.bottom , 20)
            VStack{
            InputView(text: $email , title: "Email Adress" , placeholder: "example@sqli.com")
            InputView(text: $password , title: "Password" , placeholder: "example password" , isSecureFidld: true )
            }
            CustomButton(title: "Sign In " , backgroundColor: Color(.white), foregroundColor: .black){
                authViewModel.signIn(withEmail : email , withPassword  : password , rememberMe : true ){ isLogedIn in
                    if isLogedIn {
                        navigationViewModel.navigateTo(screen: .tasklist)
                    }else {
                        print("not loged in ")
                    }
                }
            }
            if let msg = authViewModel.errorMessage  {
                Spacer().frame(height: 40)
                ErrorCardView(errorMessage: msg, actionTitle: "Error" ){
                    authViewModel.errorMessage = nil
                }
            }
           Spacer()
          
            Button(action : {
                withAnimation(.easeInOut(duration:0.5)){
                    authViewModel.errorMessage = nil 
                    navigationViewModel.navigateTo(screen: .signUp)
                }
            } , label  : {
                HStack{
                    Text("Don't have an account " ).fontWeight(.light).foregroundColor(.blue)
                    Text("Sign up").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
       
            })
        }.padding( 10)
        .navigationBarHidden(true)
        }
        
   
    }
 
struct LoginPriview : PreviewProvider{
    static var previews: some View{
        LoginView()
    }
}

