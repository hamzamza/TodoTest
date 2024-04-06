//
//  TaskViewModel.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/3/24.
//

 

import SwiftUI
import CoreData

class TaskListViewModel: ObservableObject {
    // i did all those field undeone TAsks doneTasks showen TAsks tasksArrray just because i want to imrove some performance of the app
    // so cause i don't want to render each time i chagnged the screen , I mean while navigation I don't want the user to wait a lot
    // other ways we can filter when the user does some other task like creating a new task or deleting it so it will not see the deference 
    private let service: CoreDataTaskService
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
 
    func changeFilter(_ filterBy: Filter) {
        selectedFilter = filterBy
        switch selectedFilter {
        case .All:
            showenTasks = tasksArray
        case .Done:
            showenTasks = doneTasks
        case .Undone:
            showenTasks = undoneTasks
        }
    }
    
    init( ) {
        self.service = CoreDataTaskService(viewContext: PersistenceController.shared.viewContext)
        fetchAllTasks()
        showenTasks = tasksArray
    }
    
    func fetchAllTasks() {
        do {
            tasksArray = try service.fetchAllTasks()
            filterTasks(tasksArray)
            changeFilter(selectedFilter)
        } catch {
            print("DEBUG: Some error occurred while fetching: \(error)")
        }
    }
    
    func filterTasks(_ tasks: [Task]) {
        doneTasks = tasks.filter { $0.completed }
        undoneTasks = tasks.filter { !$0.completed }
    }
    
    func toggleTaskDoneStatus(taskID: UUID) {
        do {
            try service.toggleTaskDoneStatus(taskID: taskID)
            fetchAllTasks()
        } catch {
            print("Error toggling task status: \(error)")
        }
    }
    
    func deleteTask(taskID: UUID) {
        do {
            try service.deleteTask(taskID: taskID)
            fetchAllTasks()
        } catch {
            print("Error deleting task: \(error)")
        }
    }
    
    func editTaskName(taskID: UUID, newName: String) {
        do {
            try service.editTaskName(taskID: taskID, newName: newName)
            fetchAllTasks()
        } catch {
            print("Error editing task name: \(error)")
        }
    }
    
    func addDataToCoreData(title: String) {
        do {
            try service.addTask(title: title)
            fetchAllTasks()
        } catch {
            print("Error adding task: \(error)")
        }
    }
}
