//
//  ExploreViewController.swift
//  Post
//
//  Created by Gabryel Flor de Lis on 10/24/20.
//

import UIKit

class ExploreVC: UIViewController {
    
    var message: String?
    
    // Views
    var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupViews()
    }
    
    func setupViews() {
        // Views
        messageLabel = UILabel(frame: .zero)
        messageLabel.text = "Another View Controller"
        messageLabel.textAlignment = .center
        
        self.view.addSubview(messageLabel)
        
        // Constraints
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: messageLabel)
        self.view.addConstraintsWithFormat(format: "V:|-\(self.view.frame.height/2)-[v0]", views: messageLabel)
    }
}
