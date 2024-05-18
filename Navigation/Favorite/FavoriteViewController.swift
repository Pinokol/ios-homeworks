//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Виталий Мишин on 20.03.2024.
//

import CoreData
import StorageService
import UIKit

final class FavoriteViewController: UIViewController {
    
    private let service: FavoriteServiceProtocol
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var fetchResultController: NSFetchedResultsController<FavoritesPostData> = {
        let request = FavoritesPostData.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: false)]
        let fetchResultController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: service.backgroundContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    init(service: FavoriteServiceProtocol) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "favorites".localized
        view.backgroundColor = .systemPurple
        view.addSubviews(tableView)
        setupContraints()
        setupNavigationBar()
        initialFetch()
    }
    
    private func initialFetch() {
        try? fetchResultController.performFetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "favorites_posts".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "vkBrandColor") ?? .blue]
        let setFilterBarButton = UIBarButtonItem(image: UIImage(systemName: "doc.text.magnifyingglass"), style: .plain, target: self, action: #selector(showFilterByAuthorAlert))
        let clearFilterButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(clearFilter))
        navigationItem.rightBarButtonItems = [setFilterBarButton, clearFilterButton]
    }
    
    @objc private func showFilterByAuthorAlert() {
        let alert = UIAlertController(title: "enter_author".localized, message: "sorting_posts_author".localized, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "author_name".localized
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .words
            textField.becomeFirstResponder()
        }
        alert.addAction(UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "search".localized, style: .default, handler: { [weak self] _ in
            guard let self, let textField = alert.textFields?.first, let author = textField.text else { return }
            
            fetchResultController.fetchRequest.predicate = NSPredicate(format: "author CONTAINS %@", author)
            try? fetchResultController.performFetch()
            self.tableView.reloadData()
            
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func clearFilter() {
        fetchResultController.fetchRequest.predicate = nil
        try? fetchResultController.performFetch()
        self.tableView.reloadData()
    }
    
    private func setupContraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier, for: indexPath) as? FavoriteCell else {
            return UITableViewCell()
        }
        
        let item = fetchResultController.object(at: indexPath)
        if item.author != nil {
            cell.update(model: item)
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "delete".localized) { [weak self] _,_,_ in
            guard let self else { return }
            let item = fetchResultController.object(at: indexPath)
            service.backgroundContext.delete(item)
            
            do {
                try service.backgroundContext.save()
            } catch {
                print(error.localizedDescription)
            }
            
            if let rowIndex = postExamples.firstIndex(where: {Int64($0.id) == item.id}) {
                postExamples[rowIndex].favorite = false
            }
        }
        deleteAction.image = UIImage(systemName: "star.slash")
        deleteAction.backgroundColor = UIColor(named: "vkBrandColor")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

extension FavoriteViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}



