//
//  TaskListView.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/3/24.
//

import SwiftUI
struct TaskListView: View {
    @EnvironmentObject var taskListviewModel: TaskListViewModel
    @State private var newTaskName: String = ""
    var body: some View {
        VStack {
                    List {
                        ForEach(taskListviewModel.tasksArray, id: \.id) { task in
                            Text(task.title ?? " ")
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                if let taskID = taskListviewModel.tasksArray[index].id {
                                    taskListviewModel.deleteTask(taskID: taskID)
                                }
                            }
                        }                     }
                    
                    // Text field and "Add" button
                    HStack {
                        TextField("Enter new task", text: $newTaskName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            // Add new task with newTaskName
                            taskListviewModel.addDataToCoreData(companyTitle: newTaskName, desc: "String")
                            
                            // Clear text field after adding task
                            newTaskName = ""
                        }) {
                            Image(systemName: "plus")
                                .padding()
                        }
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .padding()
                    }
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.2))
                    .edgesIgnoringSafeArea(.bottom)
                }

    }
}
struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
