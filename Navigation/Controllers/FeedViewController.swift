


import UIKit
import StorageService

final class FeedViewController: UIViewController {
    
    var post = PostFeed(title: "Мой пост")
    var viewModel = FeedModel()
    
    private lazy var feedScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
        private lazy var stackView: UIStackView = { [unowned self] in
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.clipsToBounds = true
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 25.0

        //    Реализация через СustomButton
        var feedButton1 = CustomButton(titleText: "Первый пост", titleColor: .white, backgroundColor: .systemBlue, tapAction: self.onTapShowNextView)
        stackView.addArrangedSubview(feedButton1)
        
        var feedButton2 = CustomButton(titleText: "Второй пост", titleColor: .white, backgroundColor: .systemGreen, tapAction: self.onTapShowNextView)
        stackView.addArrangedSubview(feedButton2)
        
        return stackView
    }()
    
    private lazy var checkSecretWordTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textField.textColor = .systemBlue
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите секретное слово: \(FeedModel.shared.returnCorrectSecretWord())"
        textField.textAlignment = .center
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        var button = CustomButton(titleText: "Проверка секретного слова", titleColor: .white, backgroundColor: .systemBrown, tapAction: self.actionSetStatusButtonPressed)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var resultLabelOfSecretWord: UILabel = {
        let resultLabel = UILabel()
        resultLabel.font = UIFont.boldSystemFont(ofSize: 25)
        resultLabel.numberOfLines = 0
        resultLabel.textColor = .white
        resultLabel.backgroundColor = .systemGray3
        resultLabel.textAlignment = .center
        resultLabel.alpha = 0
        resultLabel.layer.cornerRadius = 20
        resultLabel.layer.borderWidth = 1
        resultLabel.layer.borderColor = UIColor.black.cgColor
        resultLabel.layer.masksToBounds = true
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObrervers()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        checkSecretWordTextField.delegate = self
        view.addSubview(feedScrollView)
        feedScrollView.addSubview(contentView)
        contentView.addSubviews(stackView, checkSecretWordTextField, checkGuessButton, resultLabelOfSecretWord)
        
        setupContraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // через СustomButton
    private func onTapShowNextView () {
        let postViewController = PostViewController(post: post)
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private func actionSetStatusButtonPressed() {
        checkSecretWordTextField.endEditing(true)
        
        if checkSecretWordTextField.text != nil && checkSecretWordTextField.text?.count != 0 {
            viewModel.check(inputSecretWord: checkSecretWordTextField.text ?? "")
        }
    }
    
    @objc func trueSelector() {
        resultLabelOfSecretWord.text = "Верно"
        resultLabelOfSecretWord.backgroundColor = .green
        resultLabelOfSecretWord.layer.borderColor = UIColor.green.cgColor
        resultLabelOfSecretWord.alpha = 1
    }
    
    @objc func falseSelector() {
        resultLabelOfSecretWord.text = "Не верно"
        resultLabelOfSecretWord.backgroundColor = .red
        resultLabelOfSecretWord.layer.borderColor = UIColor.red.cgColor
        resultLabelOfSecretWord.alpha = 1
    }
    
    // Observers через NotificationCenter в FeedModel
    func addObrervers() {
        NotificationCenter.default.addObserver(self, selector: #selector(trueSelector), name: NSNotification.Name(rawValue: "Word is correct") , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(falseSelector), name: NSNotification.Name(rawValue: "Word is not correct") , object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Word is correct"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Word is not correct"), object: nil)
    }
    
    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            feedScrollView.contentOffset.y = keyboardSize.height - (feedScrollView.frame.height - checkGuessButton.frame.minY)
            feedScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardHide(notification: NSNotification) {
        feedScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    private func setupContraints() {
         let safeAreaLayoutGuide = view.safeAreaLayoutGuide
         NSLayoutConstraint.activate([
             feedScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
             feedScrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
             feedScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
             feedScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
             
             contentView.topAnchor.constraint(equalTo: feedScrollView.topAnchor),
             contentView.trailingAnchor.constraint(equalTo: feedScrollView.trailingAnchor),
             contentView.bottomAnchor.constraint(equalTo: feedScrollView.bottomAnchor),
             contentView.leadingAnchor.constraint(equalTo: feedScrollView.leadingAnchor),
             contentView.centerXAnchor.constraint(equalTo: feedScrollView.centerXAnchor),
             contentView.centerYAnchor.constraint(equalTo: feedScrollView.centerYAnchor),
             
             stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
             stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -80),
             stackView.heightAnchor.constraint(equalToConstant: 180),
             stackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -32),
             
             checkSecretWordTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
             checkSecretWordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             checkSecretWordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
             checkSecretWordTextField.heightAnchor.constraint(equalToConstant: 50),
             
             checkGuessButton.topAnchor.constraint(equalTo: checkSecretWordTextField.bottomAnchor, constant: 20),
             checkGuessButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             checkGuessButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
             checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
             
             resultLabelOfSecretWord.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 20),
             resultLabelOfSecretWord.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             resultLabelOfSecretWord.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
             resultLabelOfSecretWord.heightAnchor.constraint(equalToConstant: 50),
         ])
     }
}

extension FeedViewController: UITextFieldDelegate {
    
    // tap 'done' on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

