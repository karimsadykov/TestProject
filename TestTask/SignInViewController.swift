//
//  SignInViewController.swift
//  TestTask
//
//  Created by Карим Садыков on 10.03.2023.
//

import UIKit

final class SignInViewController: UIViewController, UITextFieldDelegate {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in"
        return label
    }()
    
    private let firstNameField = AuthField(type: .name)
    private let lastNameField = AuthField(type: .lastName)
    private let emailField = AuthField(type: .email)
    
    private let signInButton = AuthButton(type: .signIn, title: "Sign In")
    private let logInButton = AuthButton(type: .signUp, title: "Log In")
    private let googleButton = AuthButton(type: .signIn, title: "Sing in with Google")
    private let appleButton = AuthButton(type: .signIn, title: "Sing in with Apple")
    
    private let googleImage = UIImageView(image: UIImage(named: "google"))
    private let appleImage = UIImageView(image: UIImage(named: "apple"))
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        configureFields()
        configureButtons()
    }
    
    private func addSubviews() {
        view.addSubview(googleImage)
        view.addSubview(appleImage)
        view.addSubview(googleButton)
        view.addSubview(appleButton)
        view.addSubview(titleLabel)
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        view.addSubview(emailField)
        view.addSubview(signInButton)
        view.addSubview(logInButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.frame = CGRect(x: 142.7, y: 155.93, width: 87.52, height: 25.3)
        firstNameField.frame = CGRect(x: 44, y: 259, width: 289, height: 29)
        lastNameField.frame = CGRect(x: 44, y: 323, width: 289, height: 29)
        emailField.frame = CGRect(x: 44, y: 387, width: 289, height: 29)
        signInButton.frame = CGRect(x: 43, y: 451, width: 289, height: 46)
        logInButton.frame = CGRect(x: 173.6, y: 514.43, width: 28, height: 9.57)
        googleImage.frame = CGRect(x: 99, y: 598, width: 23.83, height: 24.22)
        appleImage.frame = CGRect(x: 99, y: 660, width: 18.38, height: 21.87)
        googleButton.frame = CGRect(x: 134.49, y: 606.92, width: 112.82, height: 11.48)
        appleButton.frame = CGRect(x: 131.49, y: 667.14, width: 105.47, height: 11.48)
    }
    
    func configureFields() {
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapKeyboardDone))
        ]
        toolBar.sizeToFit()
        firstNameField.inputAccessoryView = toolBar
        lastNameField.inputAccessoryView = toolBar
        emailField.inputAccessoryView = toolBar
    }
    
    @objc func didTapKeyboardDone() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
    }
    
    func configureButtons() {
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
    }
    
    
    @objc func didTapSignIn() {
        didTapKeyboardDone()

//        guard let email = emailField.text,
//              let password = passwordField.text,
//              !email.trimmingCharacters(in: .whitespaces).isEmpty,
//              !password.trimmingCharacters(in: .whitespaces).isEmpty,
//              password.count >= 6 else {
//
//            let alert = UIAlertController(title: "Woops", message: "Please enter a valid email and password to sign in.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//            present(alert, animated: true)
//            return
//        }
//
//        AuthManager.shared.signIn(with: email, password: password) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success:
//                    HapticsManager.shared.vibrate(for: .success)
//                    self?.dismiss(animated: true, completion: nil)
//
//                case .failure:
//                    HapticsManager.shared.vibrate(for: .error)
//                    let alert = UIAlertController(
//                        title: "Sign In Failed",
//                        message: "Please check your email and password to try again.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//                    self?.present(alert, animated: true)
//                    self?.passwordField.text = nil
//                }
//            }
//        }
    }

    @objc func didTapLogIn() {
//        didTapKeyboardDone()
//        let vc = SignUpViewController()
//        vc.title = "Create Account"
//        navigationController?.pushViewController(vc, animated: true)
    }
}
