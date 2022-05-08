//
//  ViewController.swift
//  Bomber
//
//  Created by Иван Лукъянычев on 08.05.2022.
//

import UIKit

let lightPerple: UIColor = UIColor(red: 152/255, green: 154/255, blue: 182/255, alpha: 1.0)
let backgroundBlue: UIColor = UIColor(red: 88/255, green: 94/255, blue: 106/255, alpha: 1.0)
let font: String = "Gill Sans"

class ViewController: UIViewController {
    
    private let maxNumberCount = 11
        private let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "BOMBER"
        label.textAlignment = .center
        label.textColor = lightPerple
        label.font = UIFont(name: font, size: 30)
        return label
    }()
    
    private let sendSMSButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = lightPerple
        button.layer.cornerRadius = 15
        button.setTitle("Отправить", for: .normal)
        button.setTitleColor(backgroundBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Gill Sans", size: 20)
        return button
    }()
    
    private let phoneTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = .numberPad
        field.placeholder = "Input number here"
        field.textColor = .white
        field.font = UIFont(name: "Gill Sans", size: 30)
        return field
    }()
    
    private let choiseSite: UISegmentedControl = {
        let view = UISegmentedControl(items: ["ГосУслуги", "Телеграмм", "FixPrice"])
        view.backgroundColor = lightPerple
        view.layer.cornerRadius = 5.0
        view.selectedSegmentTintColor = .white
        view.selectedSegmentIndex = 0
        view.tintColor = backgroundBlue
        return view
    }()
    
    private let warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Сообщения отправляются по 10 смс:)"
        label.numberOfLines = 2
        label.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.3)
        label.font = UIFont(name: "Gill Sans", size: 17)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundBlue
        sendSMSButton.addTarget(self, action: #selector(doRequest), for: .touchUpInside)
        phoneTextField.delegate = self
        
        view.addSubview(titleLabel)
        view.addSubview(sendSMSButton)
        view.addSubview(phoneTextField)
        view.addSubview(choiseSite)
        view.addSubview(warningLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.frame = CGRect(x: view.frame.size.width / 2 - 100,
                                  y: 80,
                                  width: 200,
                                  height: 50)
        
        phoneTextField.frame = CGRect(x: view.frame.size.width / 2 - 115,
                                      y: view.frame.size.height / 2 - 70,
                                      width: 250,
                                      height: 40)
        choiseSite.frame = CGRect(x: view.frame.size.width / 2 - 125,
                                  y: view.frame.size.height / 2,
                                  width: 250,
                                  height: 30)
        warningLabel.frame = CGRect(x: view.frame.size.width / 2 - 150,
                                    y: view.frame.size.height - 170,
                                    width: 300,
                                    height: 50)
        sendSMSButton.frame = CGRect(x: 50,
                                     y: view.frame.size.height - 120,
                                     width: view.frame.size.width - 100,
                                     height: 44)
    }
    
    @objc func doRequest() {
        guard phoneTextField.text!.count == 18 else { return }
        let toRemove = [0, 1, 1, 4, 4, 7, 9]
        
        var number = Array(phoneTextField.text!)
        print(number)
        
        for i in toRemove {
            number.remove(at: i)
        }
        
        number = String(number)
        
//        switch choiseSite.selectedSegmentIndex {
//        case 0:
//            <#code#>
//        case 1:
//            <#code#>
//        case 2:
//            <#code#>
//        default:
//            print("кашмар")
//        }
    }
    
    private func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
            guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }
            
            let range = NSString(string: phoneNumber).range(of: phoneNumber)
            var number = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
            
            if number.count > maxNumberCount {
                let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
                number = String(number[number.startIndex..<maxIndex])
            }
            
            if shouldRemoveLastDigit {
                let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
                number = String(number[number.startIndex..<maxIndex])
            }
            
            let maxIndex = number.index(number.startIndex, offsetBy: number.count)
            let regRange = number.startIndex..<maxIndex
            
            if number.count < 7 {
                let pattern = "(\\d)(\\d{3})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
            } else {
                let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
            }
            
            return "+" + number
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") + string
        textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
        return false
    }
}

