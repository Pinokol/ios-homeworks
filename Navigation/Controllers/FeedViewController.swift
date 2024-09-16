


import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Мой пост")
    
    private lazy var feedButton1: UIButton = { [unowned self] in
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4.0
        button.setTitle("Button1", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
        button.setTitleShadowColor(.black, for: .application)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var feedButton2: UIButton = { [unowned self] in
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4.0
        button.setTitle("Button2", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
        button.setTitleShadowColor(.black, for: .application)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        
        stackView.spacing = 10.0
        
        stackView.addArrangedSubview(self.feedButton1)
        stackView.addArrangedSubview(self.feedButton2)
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        setupContraints()
        view.addSubview(stackView)
        feedButton1.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        feedButton2.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        self.feedButton1.bottomAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.feedButton1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.feedButton1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.feedButton1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.feedButton2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.feedButton2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.feedButton2.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupContraints() {
        _ = view.safeAreaLayoutGuide
    }
    
    @objc
    private func buttonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

