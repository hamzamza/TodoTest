//
//  ButtonView.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/2/24.
//

import Foundation
import SwiftUI

struct CustomButton: View {
    var title: String
    var clickable : Bool = false
    var loading : Bool  = false
    var backgroundColor: Color
    var foregroundColor: Color
    var action: () -> Void
    var body: some View {
        
        Button(action: action) {
            HStack{
                Text(title).fontWeight(.semibold)
                Image(systemName:   "arrow.right")
                     
            }.foregroundColor(foregroundColor)
            .frame(width: UIScreen.main.bounds.width - 10, height: 48 )
        }.background( backgroundColor )
        .cornerRadius(10)
    }
}

struct CutomButtonPreviw : PreviewProvider {
    static var  previews: some View {
        CustomButton( title: "Submit", backgroundColor: .blue , foregroundColor: .white){
            print("button clicked ")
        }
    }
}
