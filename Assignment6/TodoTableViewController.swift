//
//  TodoTableViewController.swift
//  Assignment6
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-08.
//

import UIKit

class TodoTableViewController: UITableViewController, AddEditEmojiTVCDelegate {
    
    let cellId = "TaskCell"
    
    let priorityHeader = ["High Priority", "Medium Priority", "Low Priority"]
    
    var tasks : [[Task]] = [[],[],[]]
    
    var cont: Int = 0
    
    fileprivate var indexPathEditing : IndexPath = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: cellId)
        
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.allowsMultipleSelectionDuringEditing = true
        
        navigationItem.title = "Todo Items"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        let deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteTask))
        navigationItem.setRightBarButtonItems([addButton, deleteButton], animated: true)
        
        
    }
    
    
    private func navigateToAddEditTVC() {
        let addEditTVC = AddEditTableViewController(style: .grouped)
        addEditTVC.delegate = self
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC, animated: true, completion: nil)
    }
    
    @objc func addNewTask() {
        navigateToAddEditTVC()
    }
    
    @objc func editTast(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        
        let addEditTVC = AddEditTableViewController(style: .grouped)
        addEditTVC.delegate = self
        addEditTVC.task = tasks[indexPath.section][indexPath.row]
        
        indexPathEditing = indexPath
        
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC, animated: true, completion: nil)
    }
    
    @objc func deleteTask() {
        if let indexPath = tableView.indexPathsForSelectedRows {
            print(indexPath)
            for index in indexPath.reversed() {
                tasks[index.section].remove(at: index.row)
                tableView.deleteRows(at: [index], with: .automatic)
            }
        }
    }
    
    
    func add(_ task: Task) {
        let priorityCode = Int(task.priority)! - 1
        tasks[priorityCode].append(task)
        tableView.insertRows(at: [IndexPath(row: tasks[priorityCode].count - 1, section: priorityCode)], with: .automatic)
    }
    
    func edit(_ task: Task) {
        
        tasks[indexPathEditing.section].remove(at: indexPathEditing.row)
        tasks[indexPathEditing.section].insert(task, at: indexPathEditing.row)
        tableView.reloadRows(at: [indexPathEditing], with: .automatic)
        indexPathEditing = []
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return priorityHeader[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodoTableViewCell
        
        cell.checkLabel.isHidden = tasks[indexPath.section][indexPath.row].check
        cell.taskNameLabel.text = tasks[indexPath.section][indexPath.row].name
        cell.taskDescLabel.text = tasks[indexPath.section][indexPath.row].desc
        cell.editSymbolLabel.addTarget(self, action: #selector(editTast), for: .touchUpInside)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // update model
        var removedTask = tasks[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        removedTask.priority = String(destinationIndexPath.section + 1)
        tasks[destinationIndexPath.section].insert(removedTask, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            return
        }
        tasks[indexPath.section][indexPath.row].check.toggle()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
