//
//  TaskListService.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/6/24.
//

import Foundation

import CoreData

class CoreDataTaskService: TaskService {
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func fetchAllTasks() throws -> [Task] {
        let request = NSFetchRequest<Task>(entityName: "Task")
        return try viewContext.fetch(request)
    }
    
    func addTask(title: String) throws {
        let task = Task(context: viewContext)
        task.id = UUID()
        task.title = title
        try viewContext.save()
    }
    
    func toggleTaskDoneStatus(taskID: UUID) throws {
        guard let task = try fetchTask(withID: taskID) else { return }
        task.completed.toggle()
        try viewContext.save()
    }
    
    func deleteTask(taskID: UUID) throws {
        guard let task = try fetchTask(withID: taskID) else { return }
        viewContext.delete(task)
        try viewContext.save()
    }
    
    func editTaskName(taskID: UUID, newName: String) throws {
        guard let task = try fetchTask(withID: taskID) else { return }
        task.title = newName
        try viewContext.save()
    }
    
    private func fetchTask(withID taskID: UUID) throws -> Task? {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", taskID as CVarArg)
        return try viewContext.fetch(request).first
    }
}
