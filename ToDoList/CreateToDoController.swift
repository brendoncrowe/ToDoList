//
//  CreateToDoController.swift
//  ToDoList
//
//  Created by Brendon Crowe on 2/28/23.
//

import UIKit

class CreateToDoController: UITableViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var toDo: ToDo?
    
    private var datePickerIsHidden = true
    private let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    private let datPickerIndexPath = IndexPath(row: 1, section: 1)
    private let notesIndexPath = IndexPath(row: 0, section: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
        titleTextField.delegate = self
        
        // Multiply 24 by 60 to convert hours into minutes, then multiply by 60 again to convert minutes into seconds and get the total time in seconds for a day.
        
        datePicker.date = Date().addingTimeInterval(24*60*60)
        updateDateLabel(date: datePicker.date)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = datePicker.date
        let notes = notesTextView.text
        
        toDo = ToDo(title: title, icComplete: isComplete, dueDate: dueDate, notes: notes)
    }
    
    private func updateDateLabel(date: Date) {
        dateLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.defaultDigits).hour().month())
    }
    
    private func updateSaveButtonState() {
        let enableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = enableSaveButton
    }
    
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDateLabel(date: sender.date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datPickerIndexPath where datePickerIsHidden == true:
            return 0
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datPickerIndexPath:
            return 216
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == dateLabelIndexPath {
            datePickerIsHidden.toggle()
            updateDateLabel(date: datePicker.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    
    
}

extension CreateToDoController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
