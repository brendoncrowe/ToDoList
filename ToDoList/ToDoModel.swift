//
//  ToDoModel.swift
//  ToDoList
//
//  Created by Brendon Crowe on 2/28/23.
//

import UIKit

struct ToDo: Equatable {
    let id = UUID()
    let title: String
    let icComplete: Bool
    let dueDate: Date
    let notes: String?
    
    static func == (lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadData() -> [ToDo]? {
        return nil
    }
    
    static func loadTestData() -> [ToDo] {
        let toDo1 = ToDo(title: "Workout", icComplete: false, dueDate: Date(), notes: "Notes 1")
        let toDo2 = ToDo(title: "Study", icComplete: false, dueDate: Date(), notes: "Notes 2")
        let toDo3 = ToDo(title: "Cook", icComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [toDo1, toDo2, toDo3]
    }
}
