//
//  TodoEntity+CoreDataProperties.swift
//  AsyncSwiftConference2022
//
//  Created by Kim Insub on 2022/11/01.
//
//

import Foundation
import CoreData


extension TodoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoEntity> {
        return NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
    }

    @NSManaged public var hasDone: Bool
    @NSManaged public var content: String?

}

extension TodoEntity : Identifiable {

}
