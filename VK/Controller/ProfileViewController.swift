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
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .createColor(ligthMode: .white, darkMode: .black)
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileHeaderView else{
                return nil
            }
            headerView.delegate = self
            headerView.actionDelegate = self
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotosTableViewCell else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
                    return cell
                }
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
                return cell
            }
        let viewModel = PostTableViewCell.ViewModel(author: postModel[indexPath.row].author, image: postModel[indexPath.row].image, description: postModel[indexPath.row].description, likes: postModel[indexPath.row].likes, views: postModel[indexPath.row].views, uniqID: postModel[indexPath.row].id)
        cell.setup(with: viewModel)
        cell.index = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let vc = PhotosViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
extension ProfileViewController: ProfileHeaderViewDelegate{
    func actionButton() {
        let alert = UIAlertController(title: "", message: "logout".localized, preferredStyle: .actionSheet)
        let trashButton = UIAlertAction(title: "out".localized, style: .destructive) {_ in
            //print("Выход")
            let login = ""
            UserDefaults.standard.set(login, forKey: "authKey")
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelButton = UIAlertAction(title: "cancel".localized, style: .cancel) {_ in
            //print("Отмена")
        }
        alert.addAction(trashButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
    
}
