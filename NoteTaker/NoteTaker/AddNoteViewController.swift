//
//  AddNoteViewController.swift
//  NoteTaker
//
//  Created by Marshall Lee on 2020-09-03.
//  Copyright © 2020 Marshall. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBAction func saveNote(_ sender: Any) {
        APIFunctions.functions.addNote(title: titleTextField.text!, date: "Placeholder", note: noteTextField.text!)
        print("saved")
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        print("deleted")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Controller connected")

        // Do any additional setup after loading the view.
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
