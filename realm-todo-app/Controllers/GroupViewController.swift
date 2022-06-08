//
//  GroupViewController.swift
//  realm-todo-app
//
//  Created by Truong Nhat Anh on 07/06/2022.
//

import UIKit
import RealmSwift

class GroupViewController: UIViewController {
    let realm = try! Realm()
    var groups = [Group]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var textField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GroupCell")
        tableView.dataSource = self
        tableView.delegate = self
        textField.delegate = self
        addBtn.layer.cornerRadius = 0
        groups = Array(realm.objects(Group.self))
    }
}
// MARK: - Table view data source
extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = groups[indexPath.row].name
        cell.contentConfiguration = content
        return cell
    }
    

       
}

// MARK: - Handle add new group
extension GroupViewController {
    func addNewGroup() {
        let newGroup = Group()
        if let groupName = textField.text {
            newGroup.name = groupName
            newGroup.tasks = List<Task>()
            try! realm.write {
                realm.add(newGroup)
            }
            groups.append(newGroup)
            textField.text = ""
            tableView.reloadData()
        }
    }
}

// MARK: - Handle btn press
extension GroupViewController {
    @IBAction func addBtnPressed(_ sender: UIButton) {
        addNewGroup()
    }
}

extension GroupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addNewGroup()
        textField.endEditing(true)
        return true;
    }
}

// MARK: - Swipe left to delete
extension GroupViewController {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] (action, view, completionHandler) in
            self?.handleSwipeToDelete(indexPath: indexPath)
                completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func handleSwipeToDelete(indexPath: IndexPath) {
        // TODO: implement delete child
        try! realm.write {
            realm.delete(groups[indexPath.row])
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    

}

