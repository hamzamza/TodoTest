//
//  FilterTaskView.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/4/24.
//

import SwiftUI

struct FilterTaskView: View {
    @EnvironmentObject var taskListviewModel: TaskListViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: { taskListviewModel.changeFilter(.All) }) {
                Text("All")
                    .foregroundColor(taskListviewModel.selectedFilter == .All ? Color.white : Color.black)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 8)
                    .border(Color.black, width: 1)
                    .background(taskListviewModel.selectedFilter == .All ? Color.black : Color.clear)
            }
            
            Button(action: { taskListviewModel.changeFilter(.Done) }) {
                Text("Done")
                     .foregroundColor(taskListviewModel.selectedFilter == .Done ? Color.white : Color.black)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 8)
                    .border(Color.black, width: 1)
                    .background(taskListviewModel.selectedFilter == .Done ? Color.black : Color.clear)
            }
            
            Button(action: { taskListviewModel.changeFilter(.Undone) }) {
                Text("Undone")
                    .foregroundColor(taskListviewModel.selectedFilter == .Undone ? Color.white : Color.black)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 8)
                    .border(Color.black, width: 1)
                    .background(taskListviewModel.selectedFilter == .Undone ? Color.black : Color.clear)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color.black, lineWidth: 2)
        )
        .cornerRadius(50)
    }
}
