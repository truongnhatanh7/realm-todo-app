//
//  TaskViewController.swift
//  realm-todo-app
//
//  Created by Truong Nhat Anh on 08/06/2022.
//

import UIKit
import RealmSwift

class TaskViewController: UIViewController {
    
    var tasks = [Task]()
    var selectedGroup = Group()
    let realm = try! Realm()
    @IBOutlet weak var textField: TextFieldWithPadding!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tasks = Array(realm.objects(Task.self).where {
            $0.parent == selectedGroup
        })
    }
    
}


// MARK: - Handle add task
extension TaskViewController {
    func addNewTask() {
        let newTask = Task()
        if let taskContent = textField.text, taskContent != "" {
            newTask.content = taskContent
            try! realm.write {
                realm.add(newTask)
                selectedGroup.tasks.append(newTask)
            }
            tasks.append(newTask)
            textField.text = ""
            textField.becomeFirstResponder()
            tableView.reloadData()
        }
    }
    @IBAction func addTaskPressed(_ sender: UIButton) {
        addNewTask()
    }
}



// MARK: - Table view data source
extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tasks in group: \(selectedGroup.name)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = tasks[indexPath.row].content
        cell.contentConfiguration = content
        cell.frame.inset(by: UIEdgeInsets(top: 500, left: 18, bottom: 40, right: 18))
        return cell
        
    }
}

// MARK: - Swipe left to delete
extension TaskViewController {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completionHandler in
            self?.handleSwipeToDelete(indexPath: indexPath)
            completionHandler(true)
        }
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func handleSwipeToDelete(indexPath: IndexPath) {
        try! realm.write {
            realm.delete(tasks[indexPath.row])
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
}

// MARK: - Handle keyboard return
extension TaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addNewTask()
        textField.endEditing(true)
        return true
    }
}
