//
//  NumberListDelegate.swift
//  ListOfNumbers
//
//  Created by Gitit Halevi on 26/03/2019.
//  Copyright © 2019 Gitit Halevi. All rights reserved.
//

import UIKit

class NumberListDelegate: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    private var _theListOfNumbers: [Double]!
    var theListOfNumbers: [Double]!{
        get{
            return _theListOfNumbers
        }
        set{
            _theListOfNumbers = newValue
        }
    }
    
    
    init(theListOfNumbers: [Double]){
        _theListOfNumbers = theListOfNumbers
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theListOfNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        cell.textLabel!.text = "\(theListOfNumbers[indexPath.row])"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
