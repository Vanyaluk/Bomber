//
//  ViewController.swift
//  Bomber
//
//  Created by Иван Лукъянычев on 08.05.2022.
//

import UIKit

let lightPerple: UIColor = UIColor(red: 152/155, green: 154/155, blue: 182/155, alpha: 1.0)
let backgroundBlue: UIColor = UIColor(red: 88/255, green: 94/255, blue: 106/255, alpha: 1.0)

class ViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "BOMBER"
        label.textAlignment = .center
        label.textColor = lightPerple
        label.font = UIFont(name: "Gill Sans", size: 30)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundBlue
        
        view.addSubview(titleLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.frame = CGRect(x: view.frame.size.width / 2 - 100,
                                  y: 80,
                                  width: 200,
                                  height: 50)
    }

}

