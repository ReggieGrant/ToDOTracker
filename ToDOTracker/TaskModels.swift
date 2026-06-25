//
//  TaskModels.swift
//  ToDOTracker
//
//  Created by Reginald Grant on 6/22/26.
//

import Foundation

struct TaskItem: Identifiable, Hashable, Codable {
    
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    
}

struct TaskGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
    
}

extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(title: "School", symbolName: "book.fill", tasks: [TaskItem(title: "Do Homework"), TaskItem(title: "Do Exams")]), TaskGroup(title: "Home", symbolName: "house.fill", tasks: [TaskItem(title: "Buy groceries", isCompleted: true), TaskItem(title: "Clean Dishes")])
    ]
}
