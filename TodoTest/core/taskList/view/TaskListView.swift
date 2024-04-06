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
            FilterTaskView()
            List { 
                        ForEach(taskListviewModel.showenTasks, id: \.id) { task in
                            CardView(content: task.title ?? "",
                                     isCheckedInitially: task.completed,
                                     checkAction: { checked in
                                        taskListviewModel.toggleTaskDoneStatus(taskID: task.id!)
                                     },
                                     editAction: { newTaskName in
                                        taskListviewModel.editTaskName(taskID: task.id!, newName: newTaskName)
                                     })
                            }
                        .onDelete { indexSet in
                            for index in indexSet {
                                if let taskID = taskListviewModel.showenTasks[index].id {
                                    taskListviewModel.deleteTask(taskID: taskID)
                                }
                               }
                            }
                        }
                    HStack {
                        TextField("Add new task...", text: $newTaskName)
                            .textFieldStyle(OvalTextFieldStyle())
                        Button(action: {
                                let trimmedTaskName = newTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
                                 if !trimmedTaskName.isEmpty {
                                     taskListviewModel.addDataToCoreData(title: trimmedTaskName)
                                     newTaskName = ""
                               }
                        }) {
                            Image(systemName: "plus")
                                .padding()
                        }
                        .foregroundColor(.black)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .padding()
                    }
                    .padding(.horizontal)
                    .edgesIgnoringSafeArea(.bottom)
                }

    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}
