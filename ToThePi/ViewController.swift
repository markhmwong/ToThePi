//
//  ViewController.swift
//  ToThePi
//
//  Created by Mark Wong on 15/2/19.
//  Copyright © 2019 Mark Wong. All rights reserved.
//

import UIKit

protocol ViewControllerProtocol {
    func prepareViewController()
    func prepareView()
    func prepareAutoLayout()
}

class ViewController: UIViewController, ViewControllerProtocol {
    let NUM: Int = 990

    
    func prepareViewController() {
        print("Welcome to To The Pi")
        view.backgroundColor = UIColor.white
    }
    
    func prepareView() {
        view.addSubview(nLabel)
    }
    
    func prepareAutoLayout() {
        nLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    

    fileprivate var nLabel: UILabel = {
        let label = UILabel()
        label.text = "3.14"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareViewController()
        prepareAutoLayout()
        
        let start = Date()
        let b = Bellard()
        print("b: \(b.getDecimal(n: 21))")
        let end = Date()
        
        print("\(end.timeIntervalSince(start))")
    }
}

