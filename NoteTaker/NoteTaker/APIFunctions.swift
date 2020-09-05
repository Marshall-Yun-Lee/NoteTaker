//
//  APIFunctions.swift
//  NoteTaker
//
//  Created by Marshall Lee on 2020-09-02.
//  Copyright © 2020 Marshall. All rights reserved.
//

import Foundation
import Alamofire

struct Note: Decodable {
    var _id: String
    var title: String
    var date: String
    var note: String
}

class APIFunctions {
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    
    func fetchNotes() {
        AF.request("http://10.0.0.26:8080/fetch").response { response in
            print(response.data!)
            let data = String(data: response.data!, encoding: .utf8)
            
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    func addNote(title: String, date: String, note: String) {
        AF.request("http://10.0.0.26:8080/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note]).responseJSON { response in
            print(response)
        }
    }
    
    func updateNote(title: String, date: String, note: String, id: String) {
        AF.request("http://10.0.0.26:8080/update", method: .put, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note, "id": id]).responseJSON { response in
            print(response)
        }
    }
    
    func deleteNote(id: String) {
        AF.request("http://10.0.0.26:8080/delete", method: .delete, encoding: URLEncoding.httpBody, headers: ["id": id]).responseJSON { response in
            print(response)
            
        }
    }
}
