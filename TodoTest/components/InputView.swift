//
//  InputView.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/2/24.
//

import Foundation
import SwiftUI
struct InputView : View  {
    @Binding var text :  String
    let title : String
    let placeholder : String
    var isSecureFidld  = false
    
    var body: some View {
        VStack(alignment: .leading , spacing:  12 ) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecureFidld {
                SecureField(  placeholder ,text:  $text )
                    .autocapitalization(.none) // Disable autocapitalization
                     
                    .font(.system(size: 14))
           }
            else {
                TextField(  placeholder ,text:  $text )
                    .autocapitalization(.none) // Disable autocapitalization
                    
                    .font(.system(size: 14))
            }
            Divider()
        }.padding(.horizontal , 10 ).padding(.vertical , 4)
        
    .navigationBarHidden(true)
    }
    
}

struct InputViewPriview : PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email Adress", placeholder: "example@gmail.com" , isSecureFidld: false  )
    }
}
