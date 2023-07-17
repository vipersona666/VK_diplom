//
//  PhotosTableViewCell.swift
//  VK
//
//  Created by Andrei on 13.07.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var photoLabel: UILabel = {
        let photoLabel = UILabel(frame: .zero)
        photoLabel.text = "albom".localized
        photoLabel.textColor = .createColor(ligthMode: .black, darkMode: .white)
        photoLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        photoLabel.translatesAutoresizingMaskIntoConstraints = false
        return photoLabel
    }()
    

    private lazy var actionButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "arrow.right"), for: UIControl.State.normal)
        button.tintColor = .createColor(ligthMode: .black, darkMode: .white)
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var oneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .createColor(ligthMode: .black, darkMode: .white)
        imageView.image = UIImage(named: "1")
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var twoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .createColor(ligthMode: .black, darkMode: .white)
        imageView.layer.cornerRadius = 6
        imageView.image = UIImage(named: "2")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var threeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .createColor(ligthMode: .black, darkMode: .white)
        imageView.layer.cornerRadius = 6
        imageView.image = UIImage(named: "3")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var fourImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .createColor(ligthMode: .black, darkMode: .white)
        imageView.layer.cornerRadius = 6
        imageView.image = UIImage(named: "4")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        
        self.addSubview(self.stackView)
        self.addSubview(self.photoLabel)
        self.addSubview(self.actionButton)
        self.stackView.addArrangedSubview(oneImageView)
        self.stackView.addArrangedSubview(twoImageView)
        self.stackView.addArrangedSubview(threeImageView)
        self.stackView.addArrangedSubview(fourImageView)
        
        NSLayoutConstraint.activate([
            
            self.photoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.photoLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            //self.photoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            self.actionButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            self.actionButton.centerYAnchor.constraint(equalTo: self.photoLabel.centerYAnchor),
            //self.editButton.widthAnchor.constraint(equalToConstant: 40),
            
            self.stackView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 12),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            self.stackView.heightAnchor.constraint(equalToConstant: 75),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
        ])
    }
    
    @objc private func buttonPressed(){
        
    }
   
}



