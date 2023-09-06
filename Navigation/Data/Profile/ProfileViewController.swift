//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Виталий Мишин on 29.07.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    static let headerIdent = "header"
    static let postIdent = "post"
    private lazy var postTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero,style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileViewController.headerIdent)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: ProfileViewController.postIdent)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(self.postTableView)
        postTableView.dataSource = self
        postTableView.delegate = self
        setupConstraint()
        self.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)
    }
     
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postExamples.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewController.postIdent, for: indexPath) as? PostTableViewCell else {
            fatalError("could not dequeue Reusable Cell")
        }
        cell.update(model: postExamples[indexPath.row])
        return cell
    }

}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 270 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileViewController.headerIdent) as? ProfileHeaderView else {
            fatalError("could not dequeue Reusable Cell")
        }
        return headerView
    }
}
    
