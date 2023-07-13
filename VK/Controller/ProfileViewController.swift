//
//  FeedViewController.swift
//  VK
//
//  Created by Andrei on 10.07.2023.
//

import UIKit
//профиль с лентой новостей
class ProfileViewController: UIViewController {
    
    //заполняем таблицу данными из массива
    private var postModel = posts
   
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
   
    
    private func setupConstraints(){
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
   
   
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
                return cell
            }
        let viewModel = PostTableViewCell.ViewModel(author: postModel[indexPath.row].author, image: postModel[indexPath.row].image, description: postModel[indexPath.row].description, likes: postModel[indexPath.row].likes, views: postModel[indexPath.row].views, uniqID: postModel[indexPath.row].id)
        cell.setup(with: viewModel)
        cell.index = indexPath
        return cell
    }
}
