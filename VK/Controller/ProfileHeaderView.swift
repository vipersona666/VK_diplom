//
//  ProfileHeaderView.swift
//  VK
//
//  Created by Andrei on 15.07.2023.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject{
    func actionButton()
}

class ProfileHeaderView: UITableViewHeaderFooterView{
    
    weak var actionDelegate: ProfileHeaderViewDelegate?
    
    weak var delegate: ProfileViewController?
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right.fill"), for: UIControl.State.normal)
        button.tintColor = Palette.appButtonBackgroundColor
        button.addTarget(self, action: #selector(self.logoutPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        let imageName = "robertDowne"
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = 70
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.createColor(ligthMode: .white, darkMode: .lightGray).cgColor
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var editButton: CustomButton = {
        let customButton = CustomButton(title: "show_status".localized,
                                        textColor: .white,
                                        backgroundColorButton: Palette.appButtonBackgroundColor,
                                        clipsToBoundsOfButton: false,
                                        cornerRadius: 12,
                                        shadowOpacity: 0.7,
                                        shadowOffset: CGSize(width: 6, height: 6),
                                        translatesAutoresizingMask: false)
        customButton.addTarget = {self.buttonPressed()}
        return customButton
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel(frame: .zero)
        name.text = "Robert Downey"
        name.textColor = .createColor(ligthMode: .black, darkMode: .white)
        name.font = UIFont.boldSystemFont(ofSize: 18.0)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var infoLabel: UILabel = {
        let info = UILabel(frame: .zero)
        info.text = "Waiting for something..."
        info.textColor = .createColor(ligthMode: .black, darkMode: .white)
        info.font = UIFont.systemFont(ofSize: 14.0)
        info.translatesAutoresizingMaskIntoConstraints = false
        return info
    }()
    
    private lazy var textField: UITextField = {
        let text = UITextField(frame: .zero)
        text.backgroundColor = .createColor(ligthMode: .white, darkMode: .gray)
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = .createColor(ligthMode: .black, darkMode: .white)
        text.placeholder = "status".localized
        text.textAlignment = .center
        text.layer.cornerRadius = 12
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.createColor(ligthMode: .black, darkMode: .white).cgColor
        text.becomeFirstResponder()
        text.addTarget(self, action: #selector(self.statusTextChanged(_:)), for: .editingChanged)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var statusText = ""
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        self.addSubview(logoutButton)
        self.addSubview(avatarImageView)
        self.addSubview(editButton)
        self.addSubview(nameLabel)
        self.addSubview(infoLabel)
        self.addSubview(textField)
        
        NSLayoutConstraint.activate([
            self.logoutButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.logoutButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            //self.logoutButton.widthAnchor.constraint(equalToConstant: 140),
            //self.logoutButton.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1),
            
            self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 140),
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 28),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            self.infoLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 27),
            self.infoLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 28),
            self.infoLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            self.infoLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.textField.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 8),
            self.textField.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 28),
            self.textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            self.textField.heightAnchor.constraint(equalToConstant: 40),
            
            self.editButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 8),
            self.editButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.editButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func logoutPressed(){
        print("logout!")
        actionDelegate?.actionButton()
        
    }

    @objc private func buttonPressed(){
        infoLabel.text = statusText
        //print(statusText)
        textField.text = ""
        textField.resignFirstResponder()
    }
    
    @objc private func statusTextChanged(_ textField: UITextField){
        statusText = textField.text ?? ""
    }
    
    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard(){
        self.endEditing(true)
        
    }
    
}

