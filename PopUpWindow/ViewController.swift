//
//  ViewController.swift
//  PopUpWindow
//
//  Created by Stephen Dowless on 12/13/18.
//  Copyright © 2018 Stephan Dowless. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var success = true
    
    lazy var popUpWindow: PopUpWindow = {
        let view = PopUpWindow()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Show Pop Up Window", for: .normal)
        button.setTitleColor(UIColor.mainBlue(), for: .normal)
        button.addTarget(self, action: #selector(handleShowPopUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainBlue()
        
        view.addSubview(button)
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        visualEffectView.alpha = 0 
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Selectors
    
    @objc func handleShowPopUp() {
        view.addSubview(popUpWindow)
        popUpWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        popUpWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpWindow.heightAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        popUpWindow.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        
        popUpWindow.showSuccessMessage = success
        success = !success
        
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpWindow.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpWindow.alpha = 1
            self.popUpWindow.transform = CGAffineTransform.identity
        }
    }
}

extension ViewController: PopUpDelegate {
    
    func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()
            print("Did remove pop up window..")
        }
    }
    
    
}

extension UIColor {
    
    static func mainBlue() -> UIColor {
        return UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }
}
