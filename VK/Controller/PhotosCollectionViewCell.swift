//
//  PhotosCollectionViewCell.swift
//  VK
//
//  Created by Andrei on 17.07.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    struct ViewModel{
        let image: UIImage?
    }
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .createColor(ligthMode: .black, darkMode: .white)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewmodel: ViewModel){
        self.photoImageView.image = viewmodel.image
    }

    private func setupView(){
        self.addSubview(self.photoImageView)
        
        NSLayoutConstraint.activate([
            self.photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
