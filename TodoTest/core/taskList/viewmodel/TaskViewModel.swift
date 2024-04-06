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
    @Published var undoneTasks: [Task] = []
    @Published var doneTasks: [Task] = []
    @Published var showenTasks: [Task] = []
    @Published var selectedFilter: Filter = .All
    
    enum Filter {
        case All
        case Done
        case Undone
    }
 
    func changeFilter( _ filterBy  : Filter ){
        selectedFilter = filterBy
        switch selectedFilter {
        case .All:
            do {   showenTasks =  tasksArray   }
        case .Done :
        do { showenTasks = doneTasks}
        case .Undone :
        do { showenTasks = undoneTasks}
        
        }
    }
    init() {
        fetchAllTasks()
        showenTasks = tasksArray
    }
    
    func fetchAllTasks() {
        let request = NSFetchRequest<Task>(entityName: "Task")
        do {
            tasksArray = try viewContext.fetch(request)
            filterTasks(tasksArray)
            changeFilter(selectedFilter)
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    func filterTasks(_ tasks :  [Task]){
        doneTasks = []
        undoneTasks = []
        tasks.forEach{
            if($0.completed){
            doneTasks.append($0)
            }else{
          undoneTasks.append($0)
            }
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

    
    func addDataToCoreData(title: String ) {
        let task = Task(context: viewContext)
        task.id = UUID()
        task.title = title
        save()
        self.fetchAllTasks()
        filterTasks(tasksArray)
    }
    
    func save() {
        do {
            try viewContext.save()
            filterTasks(tasksArray)
            changeFilter(selectedFilter)
        }catch {
            print("Error saving")
        }
    }
}

