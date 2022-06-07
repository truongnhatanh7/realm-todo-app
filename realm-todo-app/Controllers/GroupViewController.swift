//
//  GroupViewController.swift
//  realm-todo-app
//
//  Created by Truong Nhat Anh on 07/06/2022.
//

import UIKit
import RealmSwift

class GroupViewController: UITableViewController {
    let realm = try! Realm()
    var groups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        let g = Group()
//        g.name = "La flame"
//        g.tasks = List<Task>()
////        groups.append(g)
//        print("test")
        
//        try! realm.write {
//          realm.add(g)
//        }
        groups = Array(realm.objects(Group.self))
        print(groups)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = groups[indexPath.row].name
        cell.contentConfiguration = content
        return cell
    }
                
}


