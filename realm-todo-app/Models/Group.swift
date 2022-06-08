//
//  Group.swift
//  realm-todo-app
//
//  Created by Truong Nhat Anh on 07/06/2022.
//

import Foundation
import RealmSwift

class Group: Object {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var name: String
    @Persisted var tasks: List<Task>
}
 
