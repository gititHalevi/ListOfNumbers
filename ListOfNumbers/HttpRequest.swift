//
//  HttpReqest.swift
//  ListOfNumbers
//
//  Created by Gitit Halevi on 30/03/2019.
//  Copyright © 2019 Gitit Halevi. All rights reserved.
//

import UIKit

class HttpRequestNumberInLists{
    var number: Int!
    var lists: [[Double]]!
    var session: URLSession!

    init(number: Int, lists: [[Double]]){
        self.number = number
        self.lists = lists
    }
    
    func startReqest(whatToDo: @escaping (Data?)->Void){
        session = URLSession(configuration: URLSessionConfiguration.default)
        let url = URL(string: "http://192.168.43.88:8080/servlet")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let task = session.uploadTask(with: urlRequest, from: getData()) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil{
                whatToDo(data)
            }else{
                whatToDo(nil)
                print("nil there is an error")
            }
            self.session.finishTasksAndInvalidate()
        }
        task.resume()
    }
    
    func getData()->Data{
        let dictionary: [String:Any] = ["lists":lists, "number":number]
        do{
            return try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        }catch{
            fatalError("debil!")
        }
    }
}
