//
//  AccountViewController.swift
//  Post
//
//  Created by Gabryel Flor de Lis on 10/24/20.
//

import UIKit

class AccountVC: UIViewController {
    
    var logoutButton: UIButton?
    
    var deleteAccountButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .systemBackground
        
    }
    
    func setupViews() {
        
        logoutButton = {
            let button = UIButton(frame: .zero)
            button.backgroundColor = .systemIndigo
            button.layer.cornerRadius = 8
            button.tintColor = .systemBackground
            button.center = view.center
            button.setTitle("Logout", for: .normal)
            button.addTarget(self, action: #selector(logout), for: .touchUpInside)
            return button
        }()
        
        deleteAccountButton = {
            let button = UIButton(frame: .zero)
            button.setTitle("Delete Account", for: .normal)
            button.layer.cornerRadius = 8
            button.backgroundColor = .systemRed
            button.titleLabel?.textColor = .systemBackground
            button.tintColor = .systemBackground
            button.addTarget(self, action: #selector(deleteAccount), for: .touchUpInside)
            
            return button
        }()
        
        view.addSubview(logoutButton!)
        view.addSubview(deleteAccountButton!)
        
        // Constraints
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: logoutButton!)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: deleteAccountButton!)
        view.addConstraintsWithFormat(format: "V:|-\(view.frame.height/2)-[v0]-50-[v1]", views: logoutButton!, deleteAccountButton!)
        
    }
    
    
    @objc func logout() {
        LoginManager.shared.logout()
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Logout Successful", message: "You have successfully been logged out!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeViewController(UINavigationController(rootViewController: LoginVC()))
            }))
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @objc func deleteAccount() {
        UserManager.shared.deleteActiveUserProfile { (result) in
            
            switch (result) {
            
            case.success(_):
                
                do {
                    try AuthManager.shared.deleteAuthCredentials()
                    
                    
                } catch (let error) {
                    print(error)
                }
                
                // Present Alert Controller
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Account Deletion Successful", message: "You have successfully deleted your account!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeViewController(UINavigationController(rootViewController: LoginVC()))
                    }))
                    self.navigationController?.present(alert, animated: true, completion: nil)
                }
                
            case.failure(let error):
                print(error)
                
                // Present Alert Controller
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Account Deletion Failed", message: "Ohh no it looks like there is a bug in the system!\nPlease try again!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.navigationController?.present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }
}
