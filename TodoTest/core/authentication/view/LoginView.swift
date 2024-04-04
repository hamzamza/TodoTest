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
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var authViewModle : AuthViewModel
    var body : some View {
        ScrollView{
        VStack( alignment  : .center ){
            Image("todo").resizable().scaledToFill().frame(  width:   UIScreen.main.bounds.height/3,  alignment: .center).padding(.bottom , 20)
            VStack{
            InputView(text: $email , title: "Email Adress" , placeholder: "example@sqli.com")
            InputView(text: $password , title: "Password" , placeholder: "example password" , isSecureFidld: true )
            }
            Spacer().frame(height: 20)
            CustomButton(title: "Sign In " , backgroundColor: Color(.systemBlue), foregroundColor: .white){
                authViewModle.signIn(withEmail : email , withPassword  : password , rememberMe : true ){ isLogedIn in
                    if isLogedIn {
                        navigationViewModel.navigateTo(screen: .tasklist)
                    }else {
                        print("not loged in ")
                    }
                }
            }
            if let msg = authViewModle.errorMessage  {
                Text(msg)
            }
           
            Spacer()
            Button(action : {
                withAnimation(.easeInOut(duration:0.5)){
                    authViewModle.errorMessage = nil 
                    navigationViewModel.navigateTo(screen: .signUp)
                }
            } , label  : {
                HStack{
                    Text("Don't have an account " ).fontWeight(.light).foregroundColor(.blue)
                    Text("Sign up").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
       
            })
        }.padding( 10).background(Color("background"))
        .navigationBarHidden(true)
        }
        }
   
    }
 
struct LoginPriview : PreviewProvider{
    static var previews: some View{
        LoginView()
    }
}

