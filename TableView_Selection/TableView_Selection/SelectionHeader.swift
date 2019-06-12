//
//  SelectionHeader.swift
//  TableView_Selection
//
//  Created by Yongseok Choi on 12/06/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit

class SelectionHeader: UITableViewHeaderFooterView {

    var titleLabel: UILabel!
    var bottomLinveView: UIView!
    var headerButton: UIButton!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.instantiateObjects()
        self.setSubviews()
        self.setLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// Extension for methods added
extension SelectionHeader {
    // MARK: Set header
    func setHeader(title: String, tag: Int) {
        self.titleLabel.text = title
        self.headerButton.tag = tag
    }
    
    // MARK: Instantiate objects
    func instantiateObjects() {
        self.titleLabel = {
            let title = UILabel()
            title.textColor = .black
            title.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            title.numberOfLines = 0
            title.translatesAutoresizingMaskIntoConstraints = false
            
            return title
        }()
        
        self.bottomLinveView = {
            let view = UIView()
            view.backgroundColor = .gray
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        self.headerButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }()
    }
    
    // MARK: Set subviews
    func setSubviews() {
        self.addSubview([
            self.titleLabel,
            self.bottomLinveView,
            self.headerButton
            ], to: self.contentView)
    }
    
    // MARK: Set layouts
    func setLayouts() {
        let safeArea = self.contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomLinveView.topAnchor, constant: -9),
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            ])
        
        NSLayoutConstraint.activate([
            self.bottomLinveView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.bottomLinveView.heightAnchor.constraint(equalToConstant: 1),
            self.bottomLinveView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.bottomLinveView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.headerButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.headerButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.headerButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.headerButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
    }
    
    func addSubview(_ views: [UIView], to: UIView) {
        for view in views {
            to.addSubview(view)
        }
    }
}
