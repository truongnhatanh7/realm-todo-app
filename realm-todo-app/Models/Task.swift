//
//  Task.swift
//  realm-todo-app
//
//  Created by Truong Nhat Anh on 07/06/2022.
//

import Foundation
import RealmSwift

class Task: Object {
    
    @Persisted var content: String?
    @Persisted var done: Bool?
    @Persisted(originProperty: "tasks") var parent: LinkingObjects<Group>
}
