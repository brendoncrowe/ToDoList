//
//  ViewController.swift
//  ToDoList
//
//  Created by Brendon Crowe on 2/28/23.
//

import UIKit

class ToDoTableView: UITableViewController, ToDoCellDelegate {
    
    var toDos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedToDos = ToDo.loadData() {
            toDos = savedToDos
        } else {
            toDos = ToDo.loadTestData()
        }
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func checkMarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var toDo = toDos[indexPath.row]
            toDo.isComplete.toggle()
            toDos[indexPath.row] = toDo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(toDos)
        }
    }
    
    @IBAction func unwindTotoDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceVC = segue.source as! CreateToDoController
        
        if let toDo = sourceVC.toDo {
            if let indexOfExistingToDo = toDos.firstIndex(of: toDo) { // the index where the element (toDo) appears
                toDos[indexOfExistingToDo] = toDo // toDo["Study"] = "Study" the same toDo object
                tableView.reloadRows(at: [IndexPath(row: indexOfExistingToDo, section: 0)], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: toDos.count, section: 0)
                toDos.append(toDo)
                tableView.insertRows(at: [newIndexPath], with: .automatic) // insert rows corresponding to indexPath [0,1,2,3, etc.]
            }
        }
        ToDo.saveToDos(toDos)
    }
    
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> CreateToDoController? {
        let detailController = CreateToDoController(coder: coder)
        
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            // if sender is the add button, return an empty controller
            // the toDo value for CreateToDoController is nil here
            return detailController
        }
        
        // this codes sets the toDo value for the CreateToDoController
        tableView.deselectRow(at: indexPath, animated: true)
        detailController?.toDo = toDos[indexPath.row]
        return detailController
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as? ToDoCell else {
            fatalError("Could not dequeue a TableViewCell")
        }
        cell.delegate = self
        let toDo = toDos[indexPath.row]
        cell.titleLabel.text = toDo.title
        cell.isCompleteButton.isSelected = toDo.isComplete
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(toDos)
        }
    }
}

