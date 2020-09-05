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
        if update {
            APIFunctions.functions.updateNote(title: titleTextField.text!, date: "Placeholder", note: noteTextField.text!, id: note!._id)
        } else {
            APIFunctions.functions.addNote(title: titleTextField.text!, date: "Placeholder", note: noteTextField.text!)
        }
        self.navigationController?.popViewController(animated: true)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
