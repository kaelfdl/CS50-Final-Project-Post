//
//  HomeViewController.swift
//  Post
//
//  Created by Gabryel Flor de Lis on 10/24/20.
//

import UIKit

struct TestResponse: Codable {
    let message: String
}

class HomeVC: UIViewController {
    
    var user: User? {
        didSet {
            DispatchQueue.main.async {
                self.welcomeLabel.text = "Hello! \(self.user!.first_name!)\n\nWelcome to Post!"
            }
        }
    }

    
    // Views
    var logoImageView: UIImageView!
    var welcomeLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupViews()
        setupUserData()
    }
    
    func setupViews() {
        // Views
        
        logoImageView = {
            let imageView = UIImageView(frame: CGRect(x: view.frame.width/2 - 75, y: view.frame.height/3 - 75, width: 150, height: 150))
            imageView.image = UIImage(named: "PostLogo")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        welcomeLabel = UILabel(frame: .zero)
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 3
        
        self.view.addSubview(logoImageView)
        self.view.addSubview(welcomeLabel)
        
        // Constraints
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: welcomeLabel)
        self.view.addConstraintsWithFormat(format: "V:|-\(self.view.frame.height/2)-[v0]", views: welcomeLabel)
    }
    
    func setupUserData() {
        // Retrieve User Data
        UserManager.shared.retrieveActiveUserProfile { (result) in
            switch (result) {
            
            case.success(let response):
                self.user = response.user
                
            case.failure(let error):
                print(error)
                
                
                // Present Alert Controller
                let alert = UIAlertController(title: "User Retrieval Failed", message: "Ohh no it looks like there is a bug in the system!\nPlease try again!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                DispatchQueue.main.async {
                    self.welcomeLabel.text = "Ohh no it looks like there is a bug in the system!\nPlease try again!"
                    self.navigationController?.present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }
}
