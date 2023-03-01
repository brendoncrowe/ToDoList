//
//  ViewController.swift
//  ToDoList
//
//  Created by Brendon Crowe on 2/28/23.
//

import UIKit

class ToDoTableView: UITableViewController {

    
    var toDos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    private func loadData() {
        toDos = ToDo.loadTestData()
    }
    
    @IBAction func unwindTotoDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceVC = segue.source as! CreateToDoController
        if let toDo = sourceVC.toDo {
            let newIndexPath = IndexPath(row: toDos.count, section: 0)
            toDos.append(toDo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        let toDo = toDos[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = toDo.title
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }


}

