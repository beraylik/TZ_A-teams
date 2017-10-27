//
//  TasksCollectionViewCell.swift
//  TestCase
//
//  Created by Gena Beraylik on 06.10.2017.
//  Copyright © 2017 Beraylik. All rights reserved.
//

import UIKit

class TasksCollectionViewCell: UICollectionViewCell {
    
    private var inputLine = String()
    private var descText = String()
    private var urlText = String()
    var task = String()
    var jsonObject = [String: Any]() {
        didSet {
            //setupViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func restUrl(number: Int) {
        switch number {
        case 0:
            let ipUrl = "http://ip.jsontest.com"
            self.task = "IP"
            requestJson(urlStr: ipUrl, task: self.task)
        case 1:
            let headersUrl = "http://header.jsontest.com"
            self.task = "Headers"
            requestJson(urlStr: headersUrl, task: self.task)
        case 4:
            let dateUrl = "http://date.jsontest.com"
            self.task = "Date"
            requestJson(urlStr: dateUrl, task: self.task)
        case 3:
            self.task = "Echo"
            self.descText = "Put your data like:\n \"key1/value1/key2/value2/\""
            self.urlText = "http://echo.jsontest.com/"
            if jsonObject.count > 0 {
                setupViews()
            } else {
                ConfigureInputView(desc: descText)
            }
            
        case 2:
            self.task = "Validation"
            self.descText = "Put your data like:\n {'key1':'value1','key2':'value2'}"
            self.urlText = "http://validate.jsontest.com/?json="
            if jsonObject.count > 0 {
                setupViews()
            } else {
                ConfigureInputView(desc: descText)
            }
            
            //configureValidation()
        default:
            self.removeFromSuperview()
            print("Wrong value")
        }
    }
    
    func ConfigureInputView(desc: String) {
        
        let inputFormView = UIView()
        inputFormView.translatesAutoresizingMaskIntoConstraints = false
        inputFormView.backgroundColor = UIColor.lightGray
        inputFormView.layer.cornerRadius = 23
        inputFormView.layer.shadowRadius = 12
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.boldSystemFont(ofSize: 36)
        headerLabel.textAlignment = .center
        headerLabel.text = self.task
        
        let inputLabel = UILabel()
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        inputLabel.font = UIFont.boldSystemFont(ofSize: 20)
        inputLabel.text = "Fill the JSON objects:"
        
        let inputTextField = UITextField()
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.backgroundColor = .white
        inputTextField.layer.cornerRadius = 10
        inputTextField.placeholder = "Enter your data..."
        inputTextField.tag = 101
        
        
        let descriptionView = UILabel()
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.numberOfLines = 0
        descriptionView.lineBreakMode = .byWordWrapping
        descriptionView.text = desc
        descriptionView.font = UIFont.boldSystemFont(ofSize: 16)
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(buttonEchoAction(sender:)), for: .touchUpInside)
        button.backgroundColor = .blue
        button.tag = 1
        
        inputFormView.addSubview(headerLabel)
        inputFormView.addSubview(inputLabel)
        inputFormView.addSubview(inputTextField)
        inputFormView.addSubview(descriptionView)
        inputFormView.addSubview(button)
        
        inputFormView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[v0]-25-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerLabel]))
        inputFormView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[v0]-25-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": inputLabel]))
        inputFormView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[v0]-25-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": inputTextField]))
        inputFormView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[v0]-25-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": descriptionView]))
        inputFormView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0(40)]-50-[v1(30)]-20-[v2(40)]-10-[v3]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerLabel, "v1": inputLabel, "v2": inputTextField, "v3": descriptionView]))
        
        inputFormView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[v0]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": button]))
        inputFormView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(50)]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": button]))
        
        self.addSubview(inputFormView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": inputFormView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": inputFormView]))
    }
    
    @objc func buttonEchoAction(sender: Any) {
        guard let senderBtn = sender as? UIButton else { return }
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        if senderBtn.tag == 1 {                             // On input mode
            
            let parent = senderBtn.superview
            for view in (parent?.subviews)! {
                if view.tag == 101 {
                    guard let inputView = view as? UITextField else { return }
                    inputLine = inputView.text!
                    print(inputLine)
                    break
                }
            }
            
            if self.task == "Validation" {
                inputLine = (inputLine.addingPercentEncoding(withAllowedCharacters: .alphanumerics))!
            }
            let echoUrl = "\(self.urlText)\(inputLine)"
            requestJson(urlStr: echoUrl, task: self.task)
        } else if senderBtn.tag == 2 {                      // On output mode
            self.jsonObject = [:]
            self.inputLine = ""
            self.ConfigureInputView(desc: descText)
        }
    }
    
    func requestJson(urlStr: String, task: String) {
        
        guard let url = URL(string: urlStr) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let content = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as? [String: Any] else { return }
                self.jsonObject = json
                DispatchQueue.main.async {
                    self.setupViews()
                }
            } catch {
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    func setupViews() {
    
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.lightGray
        containerView.layer.cornerRadius = 23
        containerView.layer.shadowRadius = 12
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.boldSystemFont(ofSize: 36)
        headerLabel.textAlignment = .center
        headerLabel.text = self.task
        
        containerView.addSubview(headerLabel)
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerLabel]))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0(40)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerLabel]))
        
        var counter = 0
        var totalHeight = 0
        for (key, value) in jsonObject {
            let strValue = String(describing: value)
            let row = newRow(key: key+":", value: strValue)
            
            let rowHeight = Int(row.frame.size.height)
            totalHeight += rowHeight
            
            containerView.addSubview(row)
            containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": row]))
            containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(totalHeight)-[v0(\(rowHeight))]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": row]))
            counter += 1
        }
        
        if self.task == "Echo" || self.task == "Validation" {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("New request", for: .normal)
            button.layer.cornerRadius = 15
            button.addTarget(self, action: #selector(buttonEchoAction(sender:)), for: .touchUpInside)
            button.backgroundColor = .blue
            button.tag = 2
            
            containerView.addSubview(button)
            containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[v0]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": button]))
            containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(50)]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": button]))
        }
        
        self.addSubview(containerView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": containerView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": containerView]))
        
    }
    
    func newRow(key: String, value: String) -> UIView {
        let keyLabl = UILabel()
        keyLabl.translatesAutoresizingMaskIntoConstraints = false
        keyLabl.lineBreakMode = .byCharWrapping
        keyLabl.numberOfLines = 0
        keyLabl.font = UIFont.systemFont(ofSize: 16)
        keyLabl.frame.size.width = self.frame.size.width - 20
        keyLabl.sizeToFit()
        keyLabl.textColor = .lightText
        keyLabl.text = key
        keyLabl.sizeToFit()
        let heightKey = keyLabl.frame.size.height
        
        let valueLabl = UILabel()
        valueLabl.translatesAutoresizingMaskIntoConstraints = false
        valueLabl.lineBreakMode = .byCharWrapping
        valueLabl.numberOfLines = 0
        valueLabl.layer.cornerRadius = 23
        valueLabl.font = UIFont.systemFont(ofSize: 20)
        valueLabl.text = value
        valueLabl.frame.size.width = self.frame.size.width - 20
        valueLabl.sizeToFit()
        let heightValue = valueLabl.frame.size.height
        
        let rowCnt = UIView()
        rowCnt.translatesAutoresizingMaskIntoConstraints = false
        
        let deviderLine = UIView()
        deviderLine.layer.borderWidth = 0.1
        deviderLine.translatesAutoresizingMaskIntoConstraints = false
        deviderLine.backgroundColor = UIColor(red: 10.0, green: 10.0, blue: 10.0, alpha: 0.5)
        
        rowCnt.addSubview(keyLabl)
        rowCnt.addSubview(valueLabl)
        rowCnt.addSubview(deviderLine)
        rowCnt.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": keyLabl]))
        rowCnt.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": valueLabl]))
        rowCnt.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": deviderLine]))
        rowCnt.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-6-[v0(\(heightKey))]-3-[v1(\(heightValue))]-3-[v2(0.5)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": keyLabl, "v1": valueLabl, "v2": deviderLine]))
        
        rowCnt.frame.size.height = CGFloat(15) + heightKey + heightValue
        return rowCnt
    }
    
}
