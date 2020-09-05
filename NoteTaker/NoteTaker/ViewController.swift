//
//  ViewController.swift
//  NoteTaker
//
//  Created by Marshall Lee on 2020-08-30.
//  Copyright © 2020 Marshall. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var notes = [Note]()
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var notesTableView: UITableView!

    // MARK: - Segue data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNoteViewController
        
        if segue.identifier == "noteDetailsSegue" {
            vc.note = notes[notesTableView.indexPathForSelectedRow!.row]
            vc.update = true
        }
    }
    
    // MARK: - Lifecycle hooks
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
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.notesTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        APIFunctions.functions.fetchNotes()
        refreshControl.endRefreshing()
    }
    
    // MARK: - table delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! NoteTableViewCell
        cell.title.text = notes[indexPath.row].title
        cell.note.text = notes[indexPath.row].note
        cell.date.text = notes[indexPath.row].date
        return cell
    }
    
    
}

// MARK: - custom delegates
protocol DataDelegate {
    func updateArray(newArray: String)
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
