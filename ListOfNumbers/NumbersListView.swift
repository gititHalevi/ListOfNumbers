//
//  NumbersListView.swift
//  ListOfNumbers
//
//  Created by Gitit Halevi on 26/03/2019.
//  Copyright © 2019 Gitit Halevi. All rights reserved.
//

import UIKit

class NumbersListView: NSObject, UITextFieldDelegate{
    //var view: UIView!
    private var view: UIView!
    private var _title: String!
    private var _place: Int!
    private var tableView: UITableView!
    private var delegate: NumberListDelegate!
    private var txtAddNumber: UITextField!
    private var btnAddNumber: UIButton!
    private var _listNumbers:[Double] = []
    
    
    init(view: UIView, place: Int){
        super.init()
        self.place = place
        title = "List \(place + 1)"
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(self.view)
        
        delegate = NumberListDelegate(theListOfNumbers: listNumbers)
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 50), style: .plain)
        tableView.dataSource = delegate
        tableView.delegate = delegate
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
        self.view.addSubview(tableView)
        hideTable()
        
        txtAddNumber = UITextField(frame: CGRect(x: 60, y: self.view.frame.height - 40, width: self.view.frame.width - 5 - 5 - 60 - 120, height: 30))
        txtAddNumber.placeholder = "Enter number"
        txtAddNumber.delegate = self
        self.view.addSubview(txtAddNumber)
        
        
        btnAddNumber = UIButton(type: .system)
        btnAddNumber.frame = CGRect(x: view.frame.width - 125, y: txtAddNumber.frame.minY, width: 120, height: 30)
        btnAddNumber.setTitle("Add number", for: .normal)
        btnAddNumber.addTarget(self, action: #selector(btnAddnumberClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(btnAddNumber)
        
        
        
    }
    
    func keyBoardDidShow(frame: CGRect){
        
        txtAddNumber.frame.origin.y = view.frame.height - 40 - frame.height
        btnAddNumber.frame.origin.y = view.frame.height - 40 - frame.height
        tableView.frame.size = CGSize(width: view.frame.width, height: view.frame.height - 50 - frame.height)
        
        
     
    }
    
    func keyBoardDidHide(frame: CGRect){
        
        txtAddNumber.frame.origin.y = view.frame.height - 40
        btnAddNumber.frame.origin.y = view.frame.height - 40
        tableView.frame.size = CGSize(width: view.frame.width, height: view.frame.height - 50)

    }
    
    
    
    @objc func btnAddnumberClicked(sender: UIButton){
        var string = txtAddNumber.text! as String
        if string.isEmpty{
            return
        }
        if string.last == "."{
            string = string.appending("0")
        }
        
        if listNumbers.count != 0{
            addToListNumberBySortedWay(theValue: Double(string)!, inPlace: listNumbers.count - 1)
        }else{
             listNumbers.insert(Double(string)! , at: 0)
        }
        delegate.theListOfNumbers = listNumbers
        tableView.reloadData()
        txtAddNumber.text = ""
    }
    func addToListNumberBySortedWay(theValue: Double, inPlace i: Int){
        //listNumbers.append(newValue)
        //var i = listNumbers.count - 1
        if i < 0{
            listNumbers.insert(theValue, at: 0)
            return
        }
        if theValue >= listNumbers[i]{
            listNumbers.insert(theValue, at: i + 1)
        } else {
            addToListNumberBySortedWay(theValue: theValue, inPlace: i - 1)
        }
        
    }
    
    var listNumbers: [Double]{
        get{
            return _listNumbers
        }
        set{
            _listNumbers = newValue
        }
    }
    
    var title: String{
        get{
            return _title
        }
        set{
            _title = newValue
        }
    }
    var place: Int{
        get{
            return _place
        }
        set{
            _place = newValue
        }
    }
    
    func hideTable(){
        view.isHidden = true
    }
    func showTable(){
        view.isHidden = false
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let current = textField.text! as NSString
        var newText = current.replacingCharacters(in: range, with: string)
        if newText == ""{
            return true
        }
        if newText.last == "."{
            newText = newText.appending("0")
            
        }
        
        
        let double = Double(newText)
        if let theDouble = double{
            if theDouble > 1000000{
                return false
            }
            return true
        }else{
            return false
        }
    }
    func textFieldBecomeResponder(){
        txtAddNumber.becomeFirstResponder()
        
    }
    func textFieldResingResponder(){
        txtAddNumber.resignFirstResponder()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldResingResponder()
        return true
    }
    
    
    
}
