//
//  CardView.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/4/24.
//
import SwiftUI
struct CardView: View {
    let content: String
    let isCheckedInitially: Bool
    let checkAction: (Bool) -> Void
    let editAction: (String ) -> Void // New edit action
    
    @State private var isChecked: Bool
    @State private var isEditing = false
    @State private var editedTitle: String
    
    init(content: String, isCheckedInitially: Bool = false, checkAction: @escaping (Bool) -> Void, editAction: @escaping (String) -> Void) {
        self.content = content
        self.isCheckedInitially = isCheckedInitially
        self.checkAction = checkAction
        self.editAction = editAction
        self._isChecked = State(initialValue: isCheckedInitially)
        self._editedTitle = State(initialValue: content)
    }

    var body: some View {
        HStack {
            if isEditing {
                TextField("Edit task...", text: $editedTitle, onCommit: {
                    isEditing = false
                    editAction(editedTitle)
                      })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(content)
                    .onTapGesture {
                    isEditing = true
               }
            }
            Spacer()
            Button(action: {
                isChecked.toggle()
                checkAction(isChecked)
            }) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .resizable().scaledToFill().frame(  width:30 ,height: 30,   alignment: .center)
                    .foregroundColor(isChecked ? .black : .black)
            }
            .padding()
        }
        .cornerRadius(10)
    }
}
