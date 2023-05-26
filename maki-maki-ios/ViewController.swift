//
//  ViewController.swift
//  maki-maki-ios
//
//  Created by Daukes on 16.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //создал кнопку
    var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🍣Maki-Maki🍕", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .orange
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setUI()
    }
    
    
    func newFuntionToMakeAPullRequest() {
        
        print("This is a dummy function which does nothing")
        
        
    }
    
    func Blablabla() {
        
        // blablabla
        
    }
    
    func setupview() {
        
        view.backgroundColor = .systemBlue
        
    }
    
    func setupHierarchy() {
        
        let newView = UIView()
        view.addSubview(newView)
        
    }
    
    func layout() {
        
    }
    
    // Jasudakjhwckjwecnjndslknk
    
    
    // Jadneiwhdowndjod

    func setUI() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

