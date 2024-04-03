//
//  TaskViewModel.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/3/24.
//

import Foundation
import CoreData
 

class TaskListViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var tasksArray: [Task] = []
    init() {
        fetchAllTasks()
    }
    
    func fetchAllTasks() {
        let request = NSFetchRequest<Task>(entityName: "Task")
        do {
            tasksArray = try viewContext.fetch(request)
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func toggleTaskDoneStatus(taskID: UUID) {
           if let taskIndex = tasksArray.firstIndex(where: { $0.id == taskID }) {
            tasksArray[taskIndex].completed.toggle()
               save()
           }
       }
    func deleteTask(taskID: UUID) {
            if let taskIndex = tasksArray.firstIndex(where: { $0.id == taskID }) {
                viewContext.delete(tasksArray[taskIndex])
                tasksArray.remove(at: taskIndex)
                save()
            }
        }
        
        func editTaskName(taskID: UUID, newName: String) {
            if let taskIndex = tasksArray.firstIndex(where: { $0.id == taskID }) {
                tasksArray[taskIndex].title = newName
                save()
            }
        }

    
    func addDataToCoreData(companyTitle: String, desc: String) {
        let task = Task(context: viewContext)
        task.id = UUID()
        task.title = companyTitle
        task.desc = desc
        save()
        self.fetchAllTasks()
    }
    
    func save() {
        do {
            try viewContext.save()
        }catch {
            print("Error saving")
        }
    }
}

