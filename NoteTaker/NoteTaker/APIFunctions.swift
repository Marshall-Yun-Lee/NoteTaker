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
}
