//
//  ViewController.swift
//  NoteTaker
//
//  Created by Marshall Lee on 2020-08-30.
//  Copyright © 2020 Marshall. All rights reserved.
//

import UIKit

protocol DataDelegate {
    func updateArray(newArray: String)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var notes = [Note]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNoteViewController
        
        if segue.identifier == "noteDetailsSegue" {
            vc.note = notes[notesTableView.indexPathForSelectedRow!.row]
            vc.update = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        return cell
    }
    
    
    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNotes()
        
        notesTableView.delegate = self
        notesTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        do {
            notes = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
        } catch {
            print("Failed to decode json")
        }
        self.notesTableView?.reloadData()
    }
}
