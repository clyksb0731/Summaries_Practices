//
//  ViewController.swift
//  CollectionView_Samples
//
//  Created by Yongseok Choi on 06/09/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flowLayout: UICollectionViewFlowLayout!
    
    var collectionView: UICollectionView!
    
    var items: [String] = ["가나다라", "ABCDEFGHI", "우리나라", "이웃나라", "태평성대", "Back to the Mac", "하늘", "강", "땅"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = .white
        
        self.initializeObjects()
        self.setDelegate()
        self.setSubview()
        self.setLayout()
        
    }
    
    func initializeObjects() {
        self.flowLayout = UICollectionViewFlowLayout()
        self.flowLayout.scrollDirection = .vertical
        self.flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        self.collectionView = {
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
            collectionView.backgroundColor = .white
            collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            
            return collectionView
        }()
    }
    
    func setDelegate() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func setSubview() {
        self.view.addSubview(self.collectionView)
    }
    
    func setLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 300),
            self.collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
        
        cell.setCell(self.items[indexPath.row])
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 100, height: 100)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 100
    }
    
}

