//
//  LogInViewController.swift
//  Navigation
//
//  Created by Виталий Мишин on 24.08.2023.
//

import UIKit

final class LogInViewController: UIViewController {
    
    var loginDelegate: LoginViewControllerDelegate?
    var coordinator: ProfileCoordinator?
    let bruteForce = BruteForce()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var vkLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 12
        stack.distribution = .fillProportionally
        stack.backgroundColor = .systemGray6
        stack.clipsToBounds = true
        return stack
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let pixel = UIImage(named: "blue_pixel") {
            button.setBackgroundImage(pixel.image(alpha: 1), for: .normal)
            button.setBackgroundImage(pixel.image(alpha: 0.8), for: .selected)
            button.setBackgroundImage(pixel.image(alpha: 0.6), for: .highlighted)
            button.setBackgroundImage(pixel.image(alpha: 0.4), for: .disabled)
        }
        
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(touchLoginButton), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var loginField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.placeholder = "Email of phone"
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.borderWidth = 0.25
        login.leftViewMode = .always
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: login.frame.height))
        login.keyboardType = .emailAddress
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.returnKeyType = .done
        login.text = "Tigr"
        login.isSecureTextEntry = true
        return login
    }()
    
    private lazy var passwordField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leftViewMode = .always
        password.placeholder = "Password"
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.25
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.isSecureTextEntry = true
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.returnKeyType = .done
        //  password.text = "qwerty"
        return password
    }()
    
    private lazy var passwordHackingButton: CustomButton  = {
        let button = CustomButton(titleText: "Подобрать пароль", titleColor: .white, backgroundColor: .systemGreen, tapAction: hackThePassword)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .gray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        loginField.delegate = self
        passwordField.delegate = self
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObservers()
    }
    
    func setupObservers(){
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setupObservers()
    }
    private func setupUI(){
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        contentView.addSubviews(vkLogo, loginStackView, loginButton, passwordHackingButton, activityIndicator)
        loginStackView.addArrangedSubview(loginField)
        loginStackView.addArrangedSubview(passwordField)
        convenientNotification()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),
            
            vkLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogo.heightAnchor.constraint(equalToConstant: 100),
            vkLogo.widthAnchor.constraint(equalToConstant: 100),
            
            loginStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),
            
            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            passwordHackingButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            passwordHackingButton.heightAnchor.constraint(equalToConstant: 50),
            passwordHackingButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            passwordHackingButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: passwordHackingButton.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: passwordHackingButton.trailingAnchor, constant: -16),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func loginErrorNotification(caseOf error: LoginError) {
        var errorMessage: String
        switch error {
        case .userNotFound:
            errorMessage = "Неправильно введен логин"
        case .wrongPassword:
            errorMessage = "Неправильно введен пароль"
        case .userNotFoundAndWrongPassword:
            errorMessage = "Неправильно введен логин и пароль"
        case .tooStrongPassword:
            errorMessage = "Пароль слижком сложный и долго подбирать"
        }
        let alertController = UIAlertController(title: "Предупреждение", message: errorMessage, preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alertController.addAction(actionAlert)
        self.present(alertController, animated: true)
    }
    
    @objc private func touchLoginButton() {
        let typedLogin = loginField.text ?? ""
        let typedPassword = passwordField.text ?? ""
        
#if DEBUG
        let userService = TestUserService()
#else
        let userService = CurrentUserService()
#endif
        
        do {
            let _ = try loginDelegate?.check(inputLogin: typedLogin, inputPassword: typedPassword)
            coordinator?.present(.profile, navigationController: self.navigationController, userService: userService.authorization())
        } catch LoginError.userNotFound {
            loginErrorNotification(caseOf: .userNotFound)
        } catch LoginError.wrongPassword {
            loginErrorNotification(caseOf: .wrongPassword)
        } catch LoginError.userNotFoundAndWrongPassword {
            loginErrorNotification(caseOf: .userNotFoundAndWrongPassword)
        } catch {
            print("some error")
        }
    }
    
    private func hackThePassword() {
        activityIndicator.startAnimating()
        loginDelegate?.passwordSelection()
        print(Checker.shared.returnCorrectPassword())
        passwordHackingButton.isEnabled = false
        let newPassword = Checker.shared.returnCorrectPassword()
        if bruteForce.isStrongPassword(passwordToUnlock: newPassword) {
            loginErrorNotification(caseOf: .tooStrongPassword)
        }
        let queue = DispatchQueue(label: "hackThePassword", qos: .background)
        queue.async { [self] in
            
            let _ = bruteForce.bruteForce(passwordToUnlock: newPassword) { result in
                
                print("🔥 \(result)")
                
                switch result {
                case .success(let forcedPassword):
                    DispatchQueue.main.async { [self] in
                        passwordField.text = forcedPassword
                        passwordField.isSecureTextEntry = false
                        activityIndicator.stopAnimating()
                        passwordHackingButton.isEnabled = true
                    }
                case .failure(_):
                    DispatchQueue.main.async { [self] in
                        loginErrorNotification(caseOf: .tooStrongPassword)
                        passwordField.text = ""
                        passwordField.isSecureTextEntry = false
                        activityIndicator.stopAnimating()
                        passwordHackingButton.isEnabled = true
                    }
                }
            }
        }
    }
    
    func convenientNotification (){
        let alertController = UIAlertController(title: "Внимание", message: "Для Вашего удобства можно установить правильные Login и Password", preferredStyle: .alert)
        let actionAlertYes = UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.loginField.text = Checker.shared.returnCorrectLogin()
            self.passwordField.text = Checker.shared.returnCorrectPassword()
        })
        let actionAlertNo = UIAlertAction(title: "No", style: .default, handler: nil)
        alertController.addAction(actionAlertYes)
        alertController.addAction(actionAlertNo)
        self.present(alertController, animated: true)
    }
    
    @objc private func keyboardShow(notification: NSNotification) {
        if let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            loginScrollView.contentOffset.y = height - (loginScrollView.frame.height - loginButton.frame.minY)
            loginScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
        }
    }
    
    @objc private func keyboardHide(notification: NSNotification) {
        loginScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

