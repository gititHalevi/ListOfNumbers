//
//  ViewController.swift
//  ListOfNumbers
//
//  Created by Gitit Halevi on 25/03/2019.
//  Copyright © 2019 Gitit Halevi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var segmentedControl: UISegmentedControl!
    var btnChoosePlace: UIButton!
    //var number : Int!
    var allLists: [NumbersListView] = []
    var displayedList = 0
    var lengthOfList: Int!
    var viewTables: UIView!
    var viewPlace: UIView!
    
    var lblChoosePlace: UILabel!
    var txtChoosPlace: UITextField!
    var btnSend: UIButton!
    var lblAnswer: UILabel!
    var prograssView: UIProgressView!
    var igulad: Igulad!
    var numberSend: Int!
    private var frameOfKayBoard: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSegmentControl()
        addBtnChoosePlace()
        addViewTable()
        addViewPlace()
        
        let tapGesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(handelTap(sender:)))
        view.addGestureRecognizer(tapGesterRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func handleKeyboardDidShow(notification: NSNotification){
        frameOfKayBoard = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        if viewPlace.isHidden == true{
            allLists[displayedList].keyBoardDidShow(frame: frameOfKayBoard)
        }else{
            
        }
        
        
        
    }
    @objc func handleKeyboardDidHide(notification: NSNotification){
        if frameOfKayBoard != nil{
            if viewPlace.isHidden == true{
                allLists[displayedList].keyBoardDidHide(frame: frameOfKayBoard)
            } else {
            
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        allLists[displayedList].textFieldBecomeResponder()
    }
    
    func addSegmentControl(){
        segmentedControl = UISegmentedControl(items: [])
        segmentedControl.frame.origin.y = 100
        segmentedControl.center.x = view.center.x
        segmentedControl.addTarget(self, action: #selector(handelCangeList(sender:)), for: .valueChanged)
        view.addSubview(segmentedControl)
        
    }
    func addBtnChoosePlace(){
        
        btnChoosePlace = UIButton(type: .system)
        btnChoosePlace.frame = CGRect(x: 5, y: segmentedControl.frame.maxY + 5, width: view.frame.width - 10, height: segmentedControl.frame.height)
        btnChoosePlace.setTitle("choose place", for: .normal)
        btnChoosePlace.addTarget(self, action: #selector(btnChooseClicked(sender:))
            , for: .touchUpInside)
        view.addSubview(btnChoosePlace)
    }
    func addViewTable(){
        let numberOfLists = 2
        let heightView = view.frame.height - (btnChoosePlace.frame.maxY + 5) - 20
        viewTables = UIView(frame: CGRect(x: 5, y: btnChoosePlace.frame.maxY + 5, width: view.frame.width - 10, height: heightView))
        view.addSubview(viewTables)
        for i in 0..<numberOfLists{
            let newList = NumbersListView(view: viewTables, place: i)
            allLists.append(newList)
            segmentedControl.insertSegment(withTitle: newList.title, at: i, animated: false)
            segmentedControl.frame.size = CGSize(width: segmentedControl.frame.width + 60, height: segmentedControl.frame.height)
            segmentedControl.center.x = view.center.x
        }
        
        if allLists.count > 0 {
            segmentedControl.selectedSegmentIndex = 0
            showList(thatPlaceIn: displayedList)
        }
    }
    func addViewPlace(){
        viewPlace = UIView(frame: CGRect(x: 0, y: 0, width: viewTables.frame.width, height: viewTables.frame.height))
        viewPlace.center = viewTables.center
        viewPlace.isHidden = true
        view.addSubview(viewPlace)
        
        lblChoosePlace = UILabel(frame: CGRect(x: 0, y: 150, width: viewPlace.frame.width, height: 30))
        lblChoosePlace.center.x = viewPlace.center.x
        //lblChoosePlace.text = "Choose number of place"
        lblChoosePlace.textAlignment = .center
        viewPlace.addSubview(lblChoosePlace)
        
        txtChoosPlace = UITextField(frame: CGRect(x: 0, y: lblChoosePlace.frame.maxY + 30, width: 250, height: 30))
        txtChoosPlace.borderStyle = .roundedRect
        txtChoosPlace.center.x = viewPlace.center.x
        txtChoosPlace.placeholder = "Enter your number"
        txtChoosPlace.delegate = self
        viewPlace.addSubview(txtChoosPlace)
        
        btnSend = UIButton(type: .system)
        btnSend.frame = CGRect(x: 0, y: txtChoosPlace.frame.maxY + 30, width: viewPlace.frame.width, height: 30)
        btnSend.center.x = viewPlace.center.x
        btnSend.setTitle("Send", for: .normal)
        btnSend.addTarget(self, action: #selector(btnSendClicked(sender:)), for: .touchUpInside)
        btnSend.isEnabled = false
        viewPlace.addSubview(btnSend)
        
        lblAnswer = UILabel(frame: CGRect(x: 0, y: btnSend.frame.maxY + 150, width: viewPlace.frame.width, height: 30))
        lblAnswer.center.x = viewPlace.center.x
        lblAnswer.textAlignment = .center
        viewPlace.addSubview(lblAnswer)
        
        let loadingView = UIView(frame: CGRect(x: 0, y: lblAnswer.frame.maxY + 10, width: 200, height: 30))
        loadingView.center.x = viewPlace.center.x
        igulad = Igulad(view: loadingView)
        //igulad.startIgulad()
        viewPlace.addSubview(loadingView)
        
        
        
    }
    @objc func handelTap(sender: UITapGestureRecognizer){
        allLists[displayedList].textFieldResingResponder()
        txtChoosPlace.resignFirstResponder()
        view.endEditing(true)
    }
    
    func showList(thatPlaceIn theNewList: Int){
        //print("displayedList: \(displayedList), theNewList: \(theNewList)")
        if viewTables.isHidden == true{
            viewPlace.isHidden = true
            viewTables.isHidden = false
        }
        allLists[displayedList].hideTable()
        displayedList = theNewList
        allLists[displayedList].showTable()
        
        allLists[displayedList].textFieldBecomeResponder()
    }
    
    @objc func handelCangeList(sender: UISegmentedControl){
        view.endEditing(true)
        txtChoosPlace.text = ""
        btnSend.isEnabled = false
        showList(thatPlaceIn: sender.selectedSegmentIndex)
    }
    @objc func btnChooseClicked(sender: UIButton){
        view.endEditing(true)
        if viewPlace.isHidden == true{
            viewTables.isHidden = true
            viewPlace.isHidden = false
            segmentedControl.selectedSegmentIndex = -1
        }
        
        
        
        setLengthOfLists()
        if lengthOfList != 0{
            lblChoosePlace.text = "Choose number between 1 to \(lengthOfList!)"
            txtChoosPlace.isEnabled = true
            txtChoosPlace.becomeFirstResponder()
        }else{
            lblChoosePlace.text = "Please fill the lists first"
            txtChoosPlace.isEnabled = false
        }
    }
    func setLengthOfLists(){
        var count = 0
        for item in allLists{
            count += item.listNumbers.count
        }
        lengthOfList = count
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let current = txtChoosPlace.text! as NSString
        let newText = current.replacingCharacters(in: range, with: string)
        if newText == ""{
            btnSend.isEnabled = false
            return true
        }
        let int = Int(newText)
        if let theInt = int{
            if theInt >= 1 && theInt <= lengthOfList{
                btnSend.isEnabled = true
                return true
            }
        }
        
        return false
    }
    
    
    @objc func btnSendClicked(sender: UIButton){
        view.endEditing(true)
        lblAnswer.text = "please waite"
        igulad.startIgulad()
        let s = txtChoosPlace.text!
        if s.isEmpty{
            return
        }
        let number = Int(s)
        guard let numberToSend = number else{ return }
        numberSend = numberToSend
        
        var lists: [[Double]] = []

        
        for item in allLists{
            lists.append(item.listNumbers)
        }
        let request = HttpRequestNumberInLists(number: numberToSend, lists: lists)
        request.startReqest { (data: Data?) in
        
            DispatchQueue.main.async {
                if let theData = data{
                    let s = String(data: theData, encoding: String.Encoding.utf8)
                    let double = Double(s!)
                    if double != nil{
                        self.lblAnswer.text = "\(self.numberSend!)th position: \(s!	)"
                    }else{
                        self.lblAnswer.text = "Error"
                    }
                }else{
                    self.lblAnswer.text = "Error"
                }
                
                    self.btnSend.isEnabled = false
                    self.txtChoosPlace.text = ""
                    self.igulad.stopIgulad()
                
            }
             
            
            
            
            
        }
        
    }


}

