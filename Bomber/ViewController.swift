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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundBlue
        sendSMSButton.addTarget(self, action: #selector(doRequest), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(sendSMSButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.frame = CGRect(x: view.frame.size.width / 2 - 100,
                                  y: 80,
                                  width: 200,
                                  height: 50)
        sendSMSButton.frame = CGRect(x: view.frame.size.width / 2 - 108,
                                     y: view.frame.size.height - 100,
                                     width: 216,
                                     height: 44)
    }
    
    @objc func doRequest() {
        print("--REQUEST HAS BEEN SENDED: 101 -0839-")
    }

}

