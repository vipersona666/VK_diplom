//
//  ViewController.swift
//  VK
//
//  Created by Andrei on 10.07.2023.
//

import UIKit
import RealmSwift
import LocalAuthentication

class LogInViewController: UIViewController {
    
    private let notifCenter = NotificationCenter.default
    
    //var loginDelegate: LoginViewControllerDelegate?
    
    var authModel = AuthUser()
    let realm = try! Realm()
    
    let context = LAContext()
    var error: NSError?
    var isBiometria: Bool = false
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
       return scrollView
    }()
    
    private lazy var logInImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        let imageName = "7100_5_02"
        imageView.image = UIImage(named: imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logInTextField: UITextField = {
        let logIn = UITextField(frame: .zero)
        logIn.placeholder = "email".localized
        logIn.textColor = .createColor(ligthMode: .black, darkMode: .white)
        logIn.text = ""
        logIn.keyboardType = .emailAddress
        logIn.font = UIFont.systemFont(ofSize: 16.0)
        logIn.tintColor = .orange
        logIn.autocapitalizationType = .none
        logIn.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        logIn.leftViewMode = .always
        logIn.clipsToBounds = true
        logIn.translatesAutoresizingMaskIntoConstraints = false
        return logIn
    }()
    
    private lazy var passTextField: UITextField = {
        let pass = UITextField(frame: .zero)
        pass.placeholder = "password".localized
        pass.textColor = .createColor(ligthMode: .black, darkMode: .white)
        pass.text = ""
        pass.font = UIFont.systemFont(ofSize: 16.0)
        pass.tintColor = .orange
        pass.autocapitalizationType = .none
        pass.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        pass.leftViewMode = .always
        pass.isSecureTextEntry = true
        pass.translatesAutoresizingMaskIntoConstraints = false
        return pass
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.backgroundColor = .systemGray6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var logInButton: CustomButton = {
        let customButton = CustomButton(title: "sign_in".localized,
                                        textColor: .white,
                                        backgroundColorButton: .orange,
                                        clipsToBoundsOfButton: true,
                                        cornerRadius: 10,
                                        shadowOpacity: 0,
                                        shadowOffset: .zero,
                                        translatesAutoresizingMask: false)
        customButton.addTarget = {self.logInbuttonPressed()}
        return customButton
    }()
    
    private lazy var signUpButton: CustomButton = {
        let customButton = CustomButton(title: "sign_up".localized,
                                        textColor: .white,
                                        backgroundColorButton: .orange,
                                        clipsToBoundsOfButton: true,
                                        cornerRadius: 10,
                                        shadowOpacity: 0,
                                        shadowOffset: .zero,
                                        translatesAutoresizingMask: false)
        customButton.addTarget = {self.signUpButtonPressed()}
        return customButton
    }()
    
    private lazy var biometricalAuthButton: CustomButton = {
        let button = CustomButton(title: "biometrical".localized,
                                  textColor: .white,
                                  backgroundColorButton: .orange,
                                  clipsToBoundsOfButton: true,
                                  cornerRadius: 10,
                                  shadowOpacity: 0,
                                  shadowOffset: .zero,
                                  translatesAutoresizingMask: false)
        button.isHidden = isBiometria
        button.addTarget = {self.biometricalButtonPressed()}
           return button
       }()
    
    private lazy var stackButton: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
//    private lazy var activityIndicator: UIActivityIndicatorView = {
//        let ai = UIActivityIndicatorView(style: .medium)
//        ai.startAnimating()
//        ai.color = .gray
//        ai.hidesWhenStopped = true
//        ai.isHidden = true
//        ai.translatesAutoresizingMaskIntoConstraints = false
//        return ai
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .createColor(ligthMode: .white, darkMode: .black)
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.logInImageView)
        self.scrollView.addSubview(self.stackView)
        //self.scrollView.addSubview(self.biometricalAuthButton)
        self.scrollView.addSubview(self.stackButton)
        self.stackView.addArrangedSubview(logInTextField)
        self.stackView.addArrangedSubview(passTextField)
        self.stackButton.addArrangedSubview(logInButton)
        self.stackButton.addArrangedSubview(signUpButton)
        self.stackButton.addArrangedSubview(biometricalAuthButton)
        
        self.setupView()
        self.setupGesture()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.checkAuthUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        notifCenter.addObserver(self, selector: #selector(didShowKeyboard),
                               name: UIResponder.keyboardWillShowNotification, object: nil)
        notifCenter.addObserver(self, selector: #selector(didHideKeyboard),
                               name: UIResponder.keyboardWillHideNotification, object: nil)

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
            isBiometria = true
        }
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notifCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notifCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    private func setupView(){
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.logInImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 120),
            self.logInImageView.widthAnchor.constraint(equalToConstant: 100),
            self.logInImageView.heightAnchor.constraint(equalToConstant: 100),
            self.logInImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.stackView.topAnchor.constraint(equalTo: self.logInImageView.bottomAnchor, constant: 120),
            self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16),
            self.stackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.stackView.heightAnchor.constraint(equalToConstant: 100),
            
            self.stackButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16),
            self.stackButton.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
            self.stackButton.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16),
            self.stackButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.stackButton.heightAnchor.constraint(equalToConstant: 148),
            
//            self.biometricalAuthButton.bottomAnchor.constraint(equalTo: self.stackButton.bottomAnchor, constant: 120),
//            self.biometricalAuthButton.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
//            self.biometricalAuthButton.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16),
//            self.biometricalAuthButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
//            self.biometricalAuthButton.heightAnchor.constraint(equalToConstant: 40),
//            self.biometricalAuthButton.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 20)

        ])
    }
    
    private func saveRealm(login: String, password: String){
        try! realm.write({
            authModel.login = login
            authModel.password = password
            realm.add(authModel)
        })
    }
    //проверка, если пользователь уже был залогинен, создаем юзера и заходим
    private func checkAuthUser(){
        let lastAuthUser = realm.objects(AuthUser.self).last
        let user = UserDefaults.standard.string(forKey: "authKey")
        if lastAuthUser != nil && lastAuthUser?.login == user {
            //let isBioAuth = false
            
            let checkerService = CheckerService()
            checkerService.checkCredentials(email: lastAuthUser!.login, password: lastAuthUser!.password) {[weak self] result in
                switch result {
                case .success(_):
                    let vc = ProfileViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                    print("auto_login".localized)
                case .failure(_):
                    print("login_error".localized)
                    let alarm = UIAlertController(title: "login_error".localized, message: "enter_login_and_password".localized, preferredStyle: .alert)
                    let alarmAction = UIAlertAction(title: "close".localized, style: .default)
                    alarm.addAction(alarmAction)
                    self?.present(alarm, animated: true)
                }
            }
        }
        else {
            print("sign_in_or_sign_up".localized)
            let alarm = UIAlertController(title: "login_error".localized, message: "sign_in_or_sign_up".localized, preferredStyle: .alert)
            let alarmAction = UIAlertAction(title: "close".localized, style: .default)
            alarm.addAction(alarmAction)
            self.present(alarm, animated: true)
        }
    }
    
    @objc private func logInbuttonPressed(){
        
        if (!logInTextField.text!.isEmpty && !passTextField.text!.isEmpty) {
            let checkerService = CheckerService()
            checkerService.checkCredentials(email: logInTextField.text!, password: passTextField.text!) { result in
                switch result{
                case .success(_):
                    let vc = ProfileViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    //сохраняем пользователя в базу рилм
                    self.saveRealm(login: self.logInTextField.text!, password: self.passTextField.text!)
                    UserDefaults.standard.set(self.logInTextField.text!, forKey: "authKey")
                    self.logInTextField.text = ""
                    self.passTextField.text = ""
                case .failure(let error):
                    print("login_error".localized, error.localizedDescription)
                    let alarm = UIAlertController(title: "login_error".localized, message: error.localizedDescription, preferredStyle: .alert)
                    let alarmAction = UIAlertAction(title: "close".localized, style: .default)
                                            alarm.addAction(alarmAction)
                                            self.present(alarm, animated: true)
                }
            }
        } else {
            let alarm = UIAlertController(title: "empty_field".localized, message: "", preferredStyle: .alert)
            let alarmAction = UIAlertAction(title: "close".localized, style: .default)
                                    alarm.addAction(alarmAction)
                                    self.present(alarm, animated: true)
        }
    }
    
    @objc private func signUpButtonPressed(){
        
        if (!logInTextField.text!.isEmpty && !passTextField.text!.isEmpty) {
            let checkerService = CheckerService()
            checkerService.signUp(email: logInTextField.text!, password: passTextField.text!) { result in
                switch result{
                case .success(_):
                    let vc = ProfileViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    //сохраняем пользователя в базу рилм
                    self.saveRealm(login: self.logInTextField.text!, password: self.passTextField.text!)
                    UserDefaults.standard.set(self.logInTextField.text!, forKey: "authKey")
                    self.logInTextField.text = ""
                    self.passTextField.text = ""
                case .failure(let error):
                    print("registration_error".localized, error.localizedDescription)
                    let alarm = UIAlertController(title: "registration_error".localized, message: error.localizedDescription, preferredStyle: .alert)
                    let alarmAction = UIAlertAction(title: "close".localized, style: .default)
                                            alarm.addAction(alarmAction)
                                            self.present(alarm, animated: true)
                }
                
            }
        } else {
            let alarm = UIAlertController(title: "empty_field".localized, message: "", preferredStyle: .alert)
            let alarmAction = UIAlertAction(title: "close".localized, style: .default)
                                    alarm.addAction(alarmAction)
                                    self.present(alarm, animated: true)
        }
    }
    
    @objc private func biometricalButtonPressed(){
        if isBiometria {
            context.evaluatePolicy(.deviceOwnerAuthentication,
                                   localizedReason: "enter_password_to_log".localized) { [weak self] success, error in
                DispatchQueue.main.async {
                    if let error = error { print(error.localizedDescription) }
                    if success {
                        self?.checkAuthUser()
                        self?.displaySuccessAlert()
                    } else {
                        self?.displayErrorAlert(error?.localizedDescription ?? "error".localized)
                    }
                }
            }
           
        } else {
            print(error?.localizedDescription ?? "")
            print("error_biometrical".localized)
        }
           
    }
    private func displaySuccessAlert(){
        let alert = UIAlertController(title: "excellent".localized, message: "authentication".localized, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok".localized, style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alert.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    private func displayErrorAlert(_ error: String){
        let alert = UIAlertController(title: "error".localized, message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok".localized, style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }

    private func setupGesture(){
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didShowKeyboard(_ notification: Notification){
        self.logInImageView.alpha = 0.3
        if let keyboardSize =
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.scrollView.setContentOffset(CGPoint(x:0, y: keyboardSize.height/2), animated: true)
            self.scrollView.verticalScrollIndicatorInsets =
            UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
        
    }

    @objc private func didHideKeyboard(){
        self.logInImageView.alpha = 1
        self.scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
                scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc private func hideKeyboard(){
        self.view.endEditing(true)
        self.scrollView.setContentOffset(.zero, animated: true)
        
    }
    // Сдвигаем scrollView.bottom вверх на высоту клавиатуры
//        @objc private func keyboardShow(notification: NSNotification) {
//            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//                scrollView.contentInset.bottom = keyboardSize.height + 32
//                scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 32, right: 0)
//            }
//        }
//        // Восстанавливаем исходное значение scrollView.bottom
//        @objc private func keyboardHide() {
//            scrollView.contentInset = .zero
//            scrollView.verticalScrollIndicatorInsets = .zero
//        }
}



