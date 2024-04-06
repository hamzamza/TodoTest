//
//  TaskListServiceProtocole.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/6/24.
//

import Foundation
protocol TaskService {
    func fetchAllTasks() throws -> [Task]
    func addTask(title: String) throws
    func toggleTaskDoneStatus(taskID: UUID) throws
    func deleteTask(taskID: UUID) throws
    func editTaskName(taskID: UUID, newName: String) throws
}
