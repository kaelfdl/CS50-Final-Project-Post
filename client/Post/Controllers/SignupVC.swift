//
//  RegistrationVC.swift
//  Post
//
//  Created by Gabryel Flor de Lis on 11/3/20.
//

import UIKit

import UIKit


class SignupVC: UIViewController {
    
    var logoImageView: UIImageView!
    var emailTextField: UITextField!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var confirmTextField: UITextField!
    var firstNameTextField: UITextField!
    var lastNameTextField: UITextField!
    var signupButton: UIButton!
    var backToLoginLabel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    // Views
    func setupViews() {
        
        view.backgroundColor = .systemBackground
        
        self.navigationController?.isNavigationBarHidden = true
        
        logoImageView = {
            let imageView = UIImageView(frame: CGRect(x: view.frame.width/2 - 25, y: view.frame.width/4 - 25, width: 50, height: 50))
            imageView.image = UIImage(named: "PostLogo")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        emailTextField = {
            let field = UITextField(frame: .zero)
            let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            field.leftView = paddingView
            field.leftViewMode = .always
            field.layer.cornerRadius = 8
            field.backgroundColor = .white
            field.textColor = .black
            field.borderStyle = .roundedRect
            field.autocapitalizationType = .none
            field.placeholder = "Email"
            return field
        }()

        usernameTextField = {
            let field = UITextField(frame: .zero)
            let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            field.leftView = paddingView
            field.leftViewMode = .always
            field.layer.cornerRadius = 8
            field.backgroundColor = .white
            field.textColor = .black
            field.borderStyle = .roundedRect
            field.autocapitalizationType = .none
            field.placeholder = "Username"
            return field
        }()
        
        passwordTextField = {
            let field = UITextField(frame: .zero)
            let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            field.leftView = paddingView
            field.leftViewMode = .always
            field.isSecureTextEntry = true
            field.layer.cornerRadius = 8
            field.backgroundColor = .white
            field.textColor = .black
            field.borderStyle = .roundedRect
            field.autocapitalizationType = .none
            field.placeholder = "Password"
            return field
        }()
        
        confirmTextField = {
            let field = UITextField(frame: .zero)
            let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            field.leftView = paddingView
            field.leftViewMode = .always
            field.isSecureTextEntry = true
            field.layer.cornerRadius = 8
            field.backgroundColor = .white
            field.textColor = .black
            field.borderStyle = .roundedRect
            field.autocapitalizationType = .none
            field.placeholder = "Confirm Password"
            return field
        }()
        
        firstNameTextField = {
            let field = UITextField(frame: .zero)
            let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            field.leftView = paddingView
            field.leftViewMode = .always
            field.layer.cornerRadius = 8
            field.backgroundColor = .white
            field.textColor = .black
            field.borderStyle = .roundedRect
            field.placeholder = "First Name"
            return field
        }()
        
        lastNameTextField = {
            let field = UITextField(frame: .zero)
            let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            field.leftView = paddingView
            field.leftViewMode = .always
            field.layer.cornerRadius = 8
            field.backgroundColor = .white
            field.textColor = .black
            field.borderStyle = .roundedRect
            field.placeholder = "Last Name"
            return field
        }()
        
        signupButton = {
            let button = UIButton(frame: .zero)
            button.setTitle("Signup", for: .normal)
            button.layer.cornerRadius = 10
            button.backgroundColor = .systemTeal
            button.titleLabel?.textColor = .systemBackground
            button.tintColor = .systemBackground
            button.addTarget(self, action: #selector(submitSignupForm), for: .touchUpInside)
            
            return button
        }()
        
        backToLoginLabel = {
            let button = UIButton(frame: .zero)
            button.setTitle("Back to Login", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
            button.setTitleColor(.systemGray, for: .normal)
            button.underlineText()
            button.addTarget(self, action: #selector(showLoginVC), for: .touchUpInside)
            return button
        }()
        
        // Subviews
        view.addSubview(logoImageView)
        view.addSubview(emailTextField)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmTextField)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(signupButton)
        view.addSubview(backToLoginLabel)
        
        // Constraints
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: emailTextField)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: usernameTextField)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: passwordTextField)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: confirmTextField)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: firstNameTextField)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: lastNameTextField)
        view.addConstraintsWithFormat(format: "H:|-100-[v0]-100-|", views: signupButton)
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: backToLoginLabel)

        view.addConstraintsWithFormat(format: "V:|-\(view.frame.height/5.5)-[v0(36)]-20-[v1(36)]-20-[v2(36)]-20-[v3(36)]-20-[v4(36)]-20-[v5(36)]-36-[v6]-20-[v7]", views: emailTextField, usernameTextField, passwordTextField, confirmTextField,firstNameTextField, lastNameTextField, signupButton, backToLoginLabel)
        
        
    }
    
    @objc func showLoginVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func submitSignupForm() {
        
        
        let url = "http://localhost:3000/signup"
        let body = [
            "email": emailTextField.text,
            "username": usernameTextField.text,
            "password": passwordTextField.text,
            "confirm": confirmTextField.text,
            "first_name": firstNameTextField.text,
            "last_name": lastNameTextField.text
        ]
        
        // Check and verify login fields
        guard let email = body["email"] as? String,
              let _ = body["username"] as? String,
              let _ = body["password"] as? String,
              let _ = body["first_name"] as? String,
              let _ = body["last_name"] as? String,
              LoginManager.shared.isValidEmail(email) else {
            
            let alert = UIAlertController(title: "Signup Failed", message: "Please Fill Up All Fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.navigationController?.present(alert, animated: true, completion: nil)
            
            return
        }
        
        // Check and confirm password
        if (passwordTextField.text != confirmTextField.text) {
            let alert = UIAlertController(title: "Signup Failed", message: "Passwords do not match!\nPlease Try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.navigationController?.present(alert, animated: true, completion: nil)
            
            return
        }
    
        
        LoginManager.shared.signup(forURLString: url, forParams: nil, forBody: body as [String : Any], forHTTPMethod: "POST", completion: {(result) in

            switch result {

            case.success(let data):
                
                if (data.success!) {
                    DispatchQueue.main.async {
                        // Successfull Signup
                        // Access Main App
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeViewController(TabBarController())
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Signup Failed", message: data.message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.navigationController?.present(alert, animated: true, completion: nil)
                    }
                }
                
            case.failure(let error):
                print(error)
            }
        })
    }
}

