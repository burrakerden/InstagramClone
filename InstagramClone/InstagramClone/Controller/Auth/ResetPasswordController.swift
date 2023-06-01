//
//  ResetPasswordController.swift
//  InstagramClone
//
//  Created by Burak Erden on 30.05.2023.
//

import UIKit

protocol ResetPasswordControllerDelegate: AnyObject {
    func controllerDidSentResetPasswordLink(_ controller: ResetPasswordController)
}

class ResetPasswordController: UIViewController {
    
    //MARK: - Properties
    var email: String?
    
    private var viewModel = ResetPasswordViewModel()
    
    weak var delegate: ResetPasswordControllerDelegate?
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Instagram_logo_white")
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        return tf
    }()
    
    private lazy var resetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.customLoginButton(buttonName: "Reset Password")
        button.isEnabled = false
        button.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        configureUI()
    }
    
    
    //MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        emailTextField.text = email
        viewModel.email = email
        updateForm()

        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16, height: 20)
        
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 180)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
    }
    
    //MARK: - Actions
    
    @objc func resetPasswordButtonTapped() {
        guard let email = emailTextField.text else {return}
        showLoader(true)
        AuthService.resetPassword(withEmail: email) { err in
            if let err = err {
                self.showMessage(withTitle: "Error", message: err.localizedDescription)
                self.showLoader(false)
            }
            
            self.delegate?.controllerDidSentResetPasswordLink(self)
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        viewModel.email = sender.text
        updateForm()
    }
    
}

//MARK: - FormViewModel

extension ResetPasswordController: FormViewModel {
    func updateForm() {
        resetPasswordButton.backgroundColor = viewModel.buttonBgColour
        resetPasswordButton.isEnabled = viewModel.formIsValid
    }
}

