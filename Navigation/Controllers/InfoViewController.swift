//
//  InfoViewController.swift
//  Navigation
//
//  Created by Виталий Мишин on 13.07.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private var residents: [Resident] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var orbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var residentsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.autoresizesSubviews = true
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: "resident")
        return tableView
    }()
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(self.alertButton)
        view.addSubviews(actionButton, titleLabel, orbitalPeriodLabel, residentsTableView)
        setupContraints()
        setTitle()
        getInfo()
        
        self.alertButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        self.alertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.alertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.alertButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    private func setupContraints(){
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            orbitalPeriodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            orbitalPeriodLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            orbitalPeriodLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            residentsTableView.topAnchor.constraint(equalTo: orbitalPeriodLabel.bottomAnchor, constant: 16),
            residentsTableView.leadingAnchor.constraint(equalTo: orbitalPeriodLabel.leadingAnchor),
            residentsTableView.trailingAnchor.constraint(equalTo: orbitalPeriodLabel.trailingAnchor),
            residentsTableView.heightAnchor.constraint(equalToConstant: 350),
            
            actionButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 20.0),
            actionButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20.0),
            actionButton.topAnchor.constraint(equalTo: residentsTableView.bottomAnchor, constant: 16),
            actionButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
    
    private func setTitle() {
        let url = SomeTitleFromNetwork().url
        NetworkService.request(url: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let title):
                    self?.titleLabel.text = title
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getInfo(){
        
        self.residents.removeAll()
        
        Task {
            if let url = PlanetFromNetwork.planet.url {
                let services = NetworkService()
                let result = await services.fetchData(request: URLRequest(url: url), as: Planets.self)
                
                print("AWAIT RESULT: \(result)")
            }
        }
        
        getInfoAboutPlanet { [ weak self] result in
            
            switch result {
            case .success(let planet):
                DispatchQueue.main.async {
                    self?.orbitalPeriodLabel.text = "период обращения планеты Татуин вокруг своей звезды: \(planet.orbitalPeriod)"
                }
                planet.residents.forEach { resident in
                    self?.getInfoAboutResident(resident: resident) { resultResident in
                        switch resultResident {
                        case .success(let resident):
                            self?.residents.append(resident)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                        DispatchQueue.main.async {
                            self?.residentsTableView.reloadData()
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func save<E: Encodable>(_ object: E, to fileName: String) -> Bool {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(formatter)
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(object)
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return false}
            let fileURL = documentDirectory.appendingPathComponent("\(fileName).json")
            
            try data.write(to: fileURL, options: .atomic)
            
            print(fileURL)
            
            return true
        } catch {
            print(error.localizedDescription)
        }
        
        return false
    }
    
    private func getInfoAboutPlanet(completion: @escaping (Result<Planets,NetworkError>) -> Void){
        guard let url = PlanetFromNetwork.planet.url else {return}
        NetworkService.fetchData(request: URLRequest(url: url), completion: completion)
    }
    
    private func getInfoAboutResident(resident: String, completion: @escaping (Result<Resident,NetworkError>) -> Void){
        guard let url = URL(string: resident) else {return}
        NetworkService.fetchData(request: URLRequest(url: url), completion: completion)
    }
    
    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.setTitle("Alert", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc
    private func buttonAction(sender: UIButton) {
        let alert = UIAlertController()
        alert.title = "Алёрт"
        alert.message = "Ура!!!\nУ нас получился алёрт"
        alert.addAction(UIAlertAction(title: "1", style: .default, handler: { _ in
            print("1")
        }))
        alert.addAction(UIAlertAction(title: "2", style: .default, handler: { _ in
            print("2")
        }))
        self.present(alert, animated: true)
    }
    
    @objc
    private func saveAction(sender: UIButton) {
        
        if self.save(self.residents, to: "Residents") { print("SUCCESS!!!")}
    }
    
}

extension InfoViewController: UITableViewDelegate {
    
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resident", for: indexPath) as! InfoTableViewCell
        cell.update(model: residents[indexPath.row])
        return cell
    }
}

