//
//  LoginVC.swift
//  Post
//
//  Created by Gabryel Flor de Lis on 10/24/20.
//

import UIKit


class LoginVC: UIViewController {
    
    var logoImageView: UIImageView!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupLabel: UIButton!
    
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
            let imageView = UIImageView(frame: CGRect(x: view.frame.width/2 - 50, y: view.frame.width/2 - 50, width: 100, height: 100))
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

        passwordTextField = {
            let field = UITextField(frame: .zero)
            let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            field.leftView = paddingView
            field.leftViewMode = .always
            field.isSecureTextEntry = true
            field.autocorrectionType = .no
            field.layer.cornerRadius = 8
            field.backgroundColor = .white
            field.textColor = .black
            field.borderStyle = .roundedRect
            field.autocapitalizationType = .none
            field.placeholder = "Password"
            return field
        }()
        
        loginButton = {
            let button = UIButton(type: .system)
            button.setTitle("Login", for: .normal)
            button.layer.cornerRadius = 8
            button.backgroundColor = .systemTeal
            button.titleLabel?.textColor = .systemBackground
            button.tintColor = .systemBackground
            button.addTarget(self, action: #selector(submitLoginForm), for: .touchUpInside)
            
            return button
        }()
        
        signupLabel = {
            let button = UIButton(frame: .zero)
            button.setTitle("Don't have an account yet? Tap here to Signup!", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
            button.setTitleColor(.systemGray, for: .normal)
            button.underlineText()
            button.addTarget(self, action: #selector(showSignupVC), for: .touchUpInside)
            return button
        }()
        
        
        // Subviews
        view.addSubview(logoImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signupLabel)
        
        // Constraints
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: emailTextField)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: passwordTextField)
        view.addConstraintsWithFormat(format: "H:|-100-[v0]-100-|", views: loginButton)
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: signupLabel)
        
        view.addConstraintsWithFormat(format: "V:|-\(view.frame.height/2.5)-[v0(36)]-20-[v1(36)]-36-[v2]-20-[v3]", views: emailTextField, passwordTextField, loginButton, signupLabel)
        
        
    }
    
    @objc func showSignupVC() {
        self.navigationController?.pushViewController(SignupVC(), animated: true)
    }
    
    @objc func submitLoginForm() {
        
        
        let url = "http://localhost:3000/login"
        let body = [
            "email": emailTextField.text ,
            "password": passwordTextField.text
        ]
        
        // Check and verify login fields
        guard let email = body["email"] as? String, let _ = body["password"] as? String, LoginManager.shared.isValidEmail(email) else {
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Login Failed", message: "Please Enter a Valid Email and Password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.navigationController?.present(alert, animated: true, completion: nil)
            }
            
            return
        }
    
        
        LoginManager.shared.login(forURLString: url, forParams: nil, forBody: body as [String : Any], forHTTPMethod: "POST", completion: {(result) in

            switch result {

            case.success(let data):
                
                if (data.success!) {
                    DispatchQueue.main.async {
                        // Successfull Login
                        // Access Main App
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeViewController(TabBarController())
                    }
                } else {
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Login Failed", message: "Please Enter a Valid Email and Password", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.navigationController?.present(alert, animated: true, completion: nil)
                    }
                }
                
            case.failure(let error):
                print(error)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Login Failed", message: "Please Enter a Valid Email and Password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.navigationController?.present(alert, animated: true, completion: nil)
                }
            }
        })
    }
}
