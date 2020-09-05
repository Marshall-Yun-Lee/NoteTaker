//
//  AddNoteViewController.swift
//  NoteTaker
//
//  Created by Marshall Lee on 2020-09-03.
//  Copyright © 2020 Marshall. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    var note: Note?
    var update: Bool = false

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBAction func saveNote(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        if update {
            APIFunctions.functions.updateNote(title: titleTextField.text!, date: date, note: noteTextField.text!, id: note!._id)
            self.navigationController?.popViewController(animated: true)
        } else if (titleTextField.text != "" && noteTextField.text != "") {
            APIFunctions.functions.addNote(title: titleTextField.text!, date: date, note: noteTextField.text!)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        APIFunctions.functions.deleteNote(id: note!._id)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !update {
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if update {
            titleTextField.text = note!.title
            noteTextField.text = note!.note
        }
    }
}
