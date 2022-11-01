//
//  CoreDataManager.swift
//  AsyncSwiftConference2022
//
//  Created by Kim Insub on 2022/11/01.
//

import CoreData
import Foundation

final class CoreDataManager {
    static let shared = CoreDataManager()

    private let databaseName = "DataModel.sqlite"
    private let container = NSPersistentCloudKitContainer(name: "DataModel")
    private var context: NSManagedObjectContext {
        container.viewContext
    }

    init() {
        loadStores()
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}

private extension CoreDataManager {
    func loadStores() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

extension CoreDataManager {
    func save() {
        do {
            try context.save()
        } catch {
            print("FAILED TO SAVE CONTEXT")
        }
    }

    func getAllTodos() -> [TodoEntity] {
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        let result = try? context.fetch(fetchRequest)
        return result ?? []
    }

    func createTodo(content: String) {
        let todo = TodoEntity(context: context)
        todo.content = content
        todo.hasDone = false
        save()
    }

    func editTodo(todo: TodoEntity) {
        todo.hasDone.toggle()
        save()
    }

    func deleteTodo(todo: TodoEntity) {
        context.delete(todo)
        save()
    }
}
