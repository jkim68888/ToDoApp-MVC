//
//  ToDoData+CoreDataProperties.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/20.
//
//

import Foundation
import CoreData


extension ToDoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoData> {
        return NSFetchRequest<ToDoData>(entityName: "ToDoData")
    }

    @NSManaged public var priority: Int64
    @NSManaged public var taskText: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var orderId: Int64

}

extension ToDoData : Identifiable {

}
