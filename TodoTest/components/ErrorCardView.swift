//
//  ErrorCardView.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/4/24.
//

import Foundation
import SwiftUI

struct ErrorCardView: View {
    let errorMessage: String
    let actionTitle: String
    let action: () -> Void
    
    init(errorMessage: String, actionTitle: String, action: @escaping () -> Void) {
        self.errorMessage = errorMessage
        self.actionTitle = actionTitle
        self.action = action
    }

    var body: some View {
        Button  (action : {self.action()} ){
            Text(errorMessage)
                .padding(8).foregroundColor(.white)
        }.padding(10)
        .background(Color.orange)
        .cornerRadius(10)
        .shadow(radius: 4 )
    }
}
 
struct ErrorCardViewPreview : PreviewProvider {
    static var previews: some View {
        ErrorCardView(errorMessage: "this is a mock error make it happen is this what you think  ", actionTitle: "Discard ", action:   {} )
    }
}
