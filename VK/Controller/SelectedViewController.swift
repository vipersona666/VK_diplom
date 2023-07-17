//
//  SelectedViewController.swift
//  VK
//
//  Created by Andrei on 10.07.2023.


import UIKit
import CoreData

class SelectedViewController: UIViewController {
    
    let coreDataManager = CoreDataManager.shared
    var idPost = [String]()
    var setupPost: [Posts] {
            get { return coreDataManager.posts }
            set { coreDataManager.posts = newValue }
        }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        coreDataManager.reloadPosts()
        tableView.reloadData()
        print(setupPost.count)
    }
    
    private func setupConstraints(){
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "favorites".localized
        
        self.view.addSubview(self.tableView)
        self.view.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           
        ])
    }
    
}

extension SelectedViewController: UITableViewDataSource, UITableViewDelegate{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setupPost.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PostTableViewCell{
            if let id = setupPost[indexPath.row].id {
                            cell.setupSelectedPost(post: id)
                        }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = coreDataManager.posts[indexPath.row]
            coreDataManager.deletePost(post: post)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}



