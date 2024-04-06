//
//  LoadingPage.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/3/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
            VStack{
            Image("todolistblackwhite").resizable().scaledToFill().frame(width:  100 , height: 100, alignment: .center)
            ProgressView( ).progressViewStyle(CircularProgressViewStyle())
 
        }
    }
}
struct LoadingPage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
