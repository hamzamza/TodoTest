//
//  TaskListViewModelTests.swift
//  TodoTestTests
//
//  Created by Hamza Douaij on 4/6/24.
//
 
    import XCTest
    import CoreData
    @testable import TodoTest

    class CoreDataTaskServiceTests: XCTestCase {
        var persistentContainer: NSPersistentContainer!
        var viewContext: NSManagedObjectContext!
        var taskService: CoreDataTaskService!

        override func setUp() {
                super.setUp()
                persistentContainer = NSPersistentContainer(name: "Task")
                let description = NSPersistentStoreDescription()
                description.type = NSInMemoryStoreType
                persistentContainer.persistentStoreDescriptions = [description]
                persistentContainer.loadPersistentStores { (storeDescription, error) in
                    XCTAssertNil(error)
                    self.viewContext = self.persistentContainer.viewContext
                    self.taskService = CoreDataTaskService(viewContext: self.viewContext)
                }
            }

        override func tearDown() {
            super.tearDown()
            // Clear the persistent store after each test
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Task")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try viewContext.execute(batchDeleteRequest)
            } catch {
                XCTFail("Failed to clear persistent store: \(error)")
            }
        }

        func testAddTask() {
            // Given
            let title = "Test Task"

            // When
            do {
                try taskService.addTask(title: title)
            } catch {
                XCTFail("Failed to add task: \(error)")
            }

            // Then
            do {
                let tasks = try taskService.fetchAllTasks()
                XCTAssertEqual(tasks.count, 1)
                XCTAssertEqual(tasks.first?.title, title)
            } catch {
                XCTFail("Failed to fetch tasks: \(error)")
            }
        }

        func testToggleTaskDoneStatus() {
            // Given
            let task = Task(context: viewContext)
            task.id = UUID()
            task.title = "Test Task"
            task.completed = false

            do {
                try viewContext.save()
            } catch {
                XCTFail("Failed to save task: \(error)")
            }

            // When
            do {
                try taskService.toggleTaskDoneStatus(taskID: task.id!)
            } catch {
                XCTFail("Failed to toggle task status: \(error)")
            }

            // Then
            do {
                let updatedTask = try XCTUnwrap(taskService.fetchAllTasks().first)
                XCTAssertTrue(updatedTask.completed)
            } catch {
                XCTFail("Failed to fetch updated task: \(error)")
            }
        }

        func testDeleteTask() {
            // Given
            let task = Task(context: viewContext)
            task.id = UUID()
            task.title = "Test Task"

            do {
                try viewContext.save()
            } catch {
                XCTFail("Failed to save task: \(error)")
            }

            // When
            do {
                try taskService.deleteTask(taskID: task.id!)
            } catch {
                XCTFail("Failed to delete task: \(error)")
            }

            // Then
            do {
                let tasks = try taskService.fetchAllTasks()
                XCTAssertEqual(tasks.count, 0)
            } catch {
                XCTFail("Failed to fetch tasks: \(error)")
            }
        }

        func testEditTaskName() {
            // Given
            let task = Task(context: viewContext)
            task.id = UUID()
            task.title = "Initial Task Title"

            do {
                try viewContext.save()
            } catch {
                XCTFail("Failed to save task: \(error)")
            }

            let newTitle = "Updated Task Title"

            // When
            do {
                try taskService.editTaskName(taskID: task.id!, newName: newTitle)
            } catch {
                XCTFail("Failed to edit task name: \(error)")
            }

            // Then
            do {
                let updatedTask = try XCTUnwrap(taskService.fetchAllTasks().first)
                XCTAssertEqual(updatedTask.title, newTitle)
            } catch {
                XCTFail("Failed to fetch updated task: \(error)")
            }
        }

        // Add more test cases as needed for other functionalities
    }
 
