//
//  AddEditTableViewController.swift
//  Assignment6
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-10.
//

import UIKit

protocol AddEditEmojiTVCDelegate: class {
    func add(_ task: Task)
    func edit(_ task: Task)
}

class AddEditTableViewController: UITableViewController {
    
    var fields : [String] = []
    lazy var saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
    
    let taskCell = AddEditTextFieldTableViewCell()
    let descCell = AddEditTextFieldTableViewCell()
    let priorityCell = AddEditTextFieldTableViewCell()
    
    
    weak var delegate: AddEditEmojiTVCDelegate?
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if task == nil {
            title = "Add Task"
            fields = ["Task", "Description","Priority (1 - High, 2 - Medium, 3 - Low)"]
        } else {
            title = "Edit Task"
            fields = ["Task", "Description"]
            taskCell.textField.text = task?.name
            descCell.textField.text = task?.desc
            //        descriptionCell.textField.text = emoji?.description
            //        usageCell.textField.text = emoji?.usage
        }
        
        // cancel button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))
        // save button
        navigationItem.rightBarButtonItem = saveButton
        
        // textfields add target action
        taskCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        descCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        priorityCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        //      descriptionCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        //      usageCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        //
        updateSaveButtonState()
    }
    
    @objc func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc func saveTask() {
        // 1. create a new Emoji
        // 2. pass the Emoji back to EmojiTableViewController & append to the emojis array
        // 3. update table view
        let newTask = Task(lName: taskCell.textField.text!, lDesc: descCell.textField.text!, lPrio: priorityCell.textField.text!)
        if task == nil {
            delegate?.add(newTask)
        } else {
            delegate?.edit(newTask)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func updateSaveButtonState() {
        let taskName = taskCell.textField.text ?? ""
        let taskDescription = descCell.textField.text ?? ""
        saveButton.isEnabled =
            !taskName.isEmpty && !taskDescription.isEmpty && validPriority(priorityCell.textField)
    }
    
    private func validPriority(_ textField: UITextField) -> Bool {
        if fields.count == 3 {
            guard let text = textField.text, text.count == 1 else { return false }
            guard Int(textField.text!) != nil else { return false }
            return ((0 < Int(textField.text!)! ) && (Int(textField.text!)! <= 3))
        }
        return true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fields.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath {
        case [0, 0]:
            return taskCell
        case [1, 0]:
            return descCell
        case [2, 0]:
            return priorityCell
        default:
            fatalError("Invalid number of cells")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fields[section]
    }
    
    
}
