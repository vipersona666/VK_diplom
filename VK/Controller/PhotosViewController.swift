//
//  PhotosViewController.swift
//  VK
//
//  Created by Andrei on 17.07.2023.
//

import UIKit

class PhotosViewController: UIViewController{
  
    private lazy var layout: UICollectionViewFlowLayout = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         layout.minimumLineSpacing = 8
         layout.minimumInteritemSpacing = 4
         layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
         return layout
     }()
 
     private lazy var collectionView: UICollectionView = {
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCell")
         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
         collectionView.dataSource = self
         collectionView.delegate = self
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         return collectionView
     }()
    
    private let imageSource: [String] = ["1","2","3","4","5","6","7","8","9","10"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "photo_gallery".localized
        self.navigationController?.navigationBar.isHidden = false
        self.setupConstraints()
       
    }
  
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
   
    private func setupConstraints(){
        self.view.addSubview(collectionView)
        self.view.backgroundColor = .white
        self.view.backgroundColor = .createColor(ligthMode: .white, darkMode: .black)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
   
}
extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        let viewModel = PhotosCollectionViewCell.ViewModel(image: UIImage(named: imageSource[indexPath.row]))
        cell.setup(with: viewModel)
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let numberOfItemsOfLine = 3.0
        let inSets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? .zero
        
        let width = collectionView.bounds.width - numberOfItemsOfLine * interItemSpacing - inSets.left - inSets.right
        let itemWidth = floor (width / numberOfItemsOfLine)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ShowPhotoViewController()
        let viewModel = ShowPhotoViewController.ViewModel(image: UIImage(named: imageSource[indexPath.row]))
        vc.setup(with: viewModel)
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true)
    }
}
