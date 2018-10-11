//
//  ViewController.swift
//  Kurinder
//
//  Created by Максим Ефимов on 09/10/2018.
//  Copyright © 2018 hapsidra. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class NameEditController: UIViewController, UITextFieldDelegate {
    
    var helloTitle: UILabel = {
        var label = UILabel(frame: CGRect())
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My name is"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "GothamRounded-Light", size: 35)
        return label
    }()
    
    var textField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "First Name"
        textField.title = "Your full name"
        textField.font = UIFont(name: "GothamRounded-Book", size: 18)
        textField.tintColor = UIColor(red: 0.9843, green: 0.3255, blue: 0.4196, alpha: 1)
        return textField
    }()
    
    var continueButton: UIButton = {
        let textField = UIButton(frame: CGRect())
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTitle("CONTINUE", for: .normal)
        textField.titleLabel?.font = UIFont(name: "GothamRounded-Book", size: 18)
        textField.backgroundColor = UIColor.lightGray
        textField.isEnabled = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.title = ""
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.view.addSubview(helloTitle)
        helloTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        helloTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        helloTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        
        self.view.addSubview(textField)
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        textField.topAnchor.constraint(equalTo: helloTitle.bottomAnchor, constant: 35).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        
        self.view.addSubview(continueButton)
        continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        continueButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40).isActive = true
        continueButton.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        
        textField.delegate = self
    }
    
    @objc func continueButtonAction() {
        print(#function)
        //self.show(NameEditController(), sender: self)
    }
    
    func textDidChange(_ textInput: UITextInput?) {
        print(#function, textField.text!)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var mySubstring = ""
        if string.isEmpty {
            let index = textField.text!.index(textField.text!.startIndex, offsetBy: textField.text!.count - 1)
            mySubstring = String(textField.text![..<index]) // Hello
        }
        else {
            mySubstring = textField.text! + string
        }
        continueButton.isEnabled = !mySubstring.isEmpty
        if continueButton.isEnabled {
            UIView.animate(withDuration: 0.5) {
                self.continueButton.backgroundColor = UIColor(red: 0.9843, green: 0.3255, blue: 0.4196, alpha: 1)
            }
        }
        else {
            UIView.animate(withDuration: 0.5) {
                self.continueButton.backgroundColor = .lightGray
            }
        }
        print(#function, mySubstring)
        return true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

