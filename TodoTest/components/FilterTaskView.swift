//
//  FilterTaskView.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/4/24.
//

import SwiftUI

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(isSelected ? .white : .black)
                .padding(.horizontal, 30)
                .padding(.vertical, 8)
                .border(Color.black, width: 1)
                .background(isSelected ? Color.black : Color.clear)
        }
    }
}

struct FilterTaskView: View {
    @EnvironmentObject var taskListviewModel: TaskListViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            FilterButton(title: "All", isSelected: taskListviewModel.selectedFilter == .All) {
                taskListviewModel.changeFilter(.All)
            }
            
            FilterButton(title: "Done", isSelected: taskListviewModel.selectedFilter == .Done) {
                taskListviewModel.changeFilter(.Done)
            }
            
            FilterButton(title: "Undone", isSelected: taskListviewModel.selectedFilter == .Undone) {
                taskListviewModel.changeFilter(.Undone)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color.black, lineWidth: 2)
        )
        .cornerRadius(50)
    }
}
