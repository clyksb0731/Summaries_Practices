//
//  Cell.swift
//  CollectionView_Samples
//
//  Created by Yongseok Choi on 18/09/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    var label: UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setSubview()
        self.setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Cell {
    func setCell(_ content: String) {
        self.label.text = content
        self.backgroundColor = .yellow
    }
    
    func setSubview() {
        self.addSubview(self.label)
    }
    
    func setLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.label.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.label.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.label.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            self.label.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
            self.label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 3),
            self.label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -3)
            ])
        
//        NSLayoutConstraint.activate([
//            self.label.topAnchor.constraint(equalTo: safeArea.topAnchor),
//            self.label.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
//            self.label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
//            self.label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
//            ])
    }
}
