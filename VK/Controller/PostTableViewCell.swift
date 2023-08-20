//
//  PostTableViewCell.swift
//  VK
//
//  Created by Andrei on 12.07.2023.
//

import UIKit
import CoreData

//создаем ячейку с постами, данные берем из coredata
class PostTableViewCell: UITableViewCell {
    
    var index: IndexPath?
    //let coreDataManager = CoreDataManager.shared
    let coreDataService = CoreDataService.shared
    private var url: URL?
    private var model = CoreDataService.shared.postsData

    
    struct ViewModel{
        let author: String
        let image: URL
        let description: String
        let likes: Int
        //let views: Int
        //let uniqID: String
    }
    
    private lazy var authorLabel: UILabel = {
        let name = UILabel()
        name.textColor = .createColor(ligthMode: .black, darkMode: .white)
        name.font = UIFont.boldSystemFont(ofSize: 20.0)
        name.numberOfLines = 2
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .createColor(ligthMode: .black, darkMode: .black)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let description = UILabel()
        description.textColor = .createColor(ligthMode: .black, darkMode: .white)
        description.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.textColor = .createColor(ligthMode: .black, darkMode: .white)
        likesLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        return likesLabel
    }()
    
//    private lazy var viewsLabel: UILabel = {
//        let viewsLabel = UILabel()
//        viewsLabel.textColor = .createColor(ligthMode: .black, darkMode: .white)
//        viewsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
//        return viewsLabel
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(with viewmodel: ViewModel) {
        self.authorLabel.text = viewmodel.author
        self.postImageView.load(url: viewmodel.image) 
        self.descriptionLabel.text = "Status: \(viewmodel.description)"
        self.likesLabel.text = "Number: \(viewmodel.likes)"
        //self.viewsLabel.text = "Views: \(viewmodel.views)"
       coreDataService.reloadData()

    }
   
    func setupSelectedPost(post: String){
        coreDataService.reloadData()
        
        if let index = coreDataService.data.firstIndex(where: { $0.id == post })  {
            let imageURL = coreDataService.data[index].image ?? "no data"
            if let url = URL(string: imageURL ) {
                self.url = url
            }
            //print("Index: \(index)")
            authorLabel.text = coreDataService.data[index].name
            postImageView.load(url: url!)
            descriptionLabel.text = "Status: \(coreDataService.data[index].status ?? "no status")"
            likesLabel.text = "Number: \(coreDataService.data[index].id ?? "no number")"
            //viewsLabel.text = "Views: \(coreDataManager.posts[index].views)"
        }
        
    }
    
    
    private func setupView(){
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        self.addSubview(self.authorLabel)
        self.addSubview(self.postImageView)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.likesLabel)
        //self.addSubview(self.viewsLabel)
        
        NSLayoutConstraint.activate([
            self.authorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.authorLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.postImageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 12),
            self.postImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.postImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.postImageView.heightAnchor.constraint(equalTo: self.widthAnchor),
     
            self.descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.likesLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.likesLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.likesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        
//            self.viewsLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
//            self.viewsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            self.viewsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    @objc func doubleTap() {
        //print(index?.row ?? 0)
        
           if index != nil {
               if let _ = coreDataService.data.firstIndex(where: { $0.id == String(model[index?.row ?? 0].id) }) {
                   print("Эта запись уже в избранном!")
                   let alert = UIAlertController(title: "alert_check_word".localized, message: .none, preferredStyle: .actionSheet)
                   let cancelButton = UIAlertAction(title: "ok".localized, style: .cancel) {_ in
                   }
                   //окно алерт, с сообщением о дубликате
                   alert.addAction(cancelButton)
                   let keyWindow = UIApplication.shared.connectedScenes
                           .filter({$0.activationState == .foregroundActive})
                           .map({$0 as? UIWindowScene})
                           .compactMap({$0})
                           .first?.windows
                           .filter({$0.isKeyWindow}).first
                   keyWindow?.endEditing(true)
                   keyWindow?.rootViewController?.present(alert, animated: true)
               } else {
                   let alert = UIAlertController(title: "hero".localized, message: "hero_post".localized, preferredStyle: .alert)
                   
                   let keyWindow = UIApplication.shared.connectedScenes
                           .filter({$0.activationState == .foregroundActive})
                           .map({$0 as? UIWindowScene})
                           .compactMap({$0})
                           .first?.windows
                           .filter({$0.isKeyWindow}).first
                   keyWindow?.endEditing(true)
                   keyWindow?.rootViewController?.present(alert, animated: true)
                   
                   DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                       alert.dismiss(animated: true, completion: nil)
                   }
                   //print("coreDataService.data.first?.name: \(String(describing: coreDataService.postsData.first?.name))")
                   
                   coreDataService.createData (id: String(model[index!.row].id) , status: model[index!.row].status , name: model[index!.row].name , image: model[index!.row].image )
                   //coreDataManager.reloadPosts()
                   coreDataService.reloadData()
                   
               }
           }
        
       }
}
