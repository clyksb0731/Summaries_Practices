//
//  TableViewCell.swift
//  TableViewSummary
//
//  Created by 최용석 on 29/10/2018.
//  Copyright © 2018 최용석. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var sequence: UILabel!
    var viewControllerName: UILabel!
    
    var safeGuide: UILayoutGuide!
    var marginGuide: UILayoutGuide!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.safeGuide = self.contentView.safeAreaLayoutGuide
        self.marginGuide = self.contentView.layoutMarginsGuide
        
        self.createObjects()
        self.setAnchor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createObjects() {
        
        // For sequnces of view controllers
        self.sequence = UILabel()
        self.sequence.textColor = .black
        self.sequence.textAlignment = .center
        self.sequence.font = UIFont.systemFont(ofSize: 20)
        //        self.sequence.layer.borderColor = UIColor.black.cgColor
        //        self.sequence.layer.borderWidth = 1
        
        self.sequence.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.sequence)
        
        // For viewController's name
        self.viewControllerName = UILabel()
        self.viewControllerName.textColor = .black
        self.viewControllerName.textAlignment = .center
        self.viewControllerName.font = UIFont.systemFont(ofSize: 20)
        //        self.viewControllerName.layer.borderColor = UIColor.black.cgColor
        //        self.viewControllerName.layer.borderWidth = 1
        
        self.viewControllerName.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.viewControllerName)
    }
    
    func setAnchor() {
        
        // Layout of view controllers' sequence
        self.sequence.widthAnchor.constraint(equalTo: self.marginGuide.widthAnchor, multiplier: 0.2).isActive = true
        self.sequence.leadingAnchor.constraint(equalTo: self.marginGuide.leadingAnchor).isActive = true
        self.sequence.topAnchor.constraint(equalTo: self.marginGuide.topAnchor).isActive = true
        self.sequence.bottomAnchor.constraint(equalTo: self.marginGuide.bottomAnchor).isActive = true
        
        // Layout of view controllers' name
        self.viewControllerName.widthAnchor.constraint(equalTo: self.marginGuide.widthAnchor, multiplier: 0.8).isActive = true
        self.viewControllerName.trailingAnchor.constraint(equalTo: self.marginGuide.trailingAnchor).isActive = true
        self.viewControllerName.topAnchor.constraint(equalTo: self.marginGuide.topAnchor).isActive = true
        self.viewControllerName.bottomAnchor.constraint(equalTo: self.marginGuide.bottomAnchor).isActive = true
        
        /// Safe Area to test
        //        // Layout of view controllers' sequence
        //        self.sequence.widthAnchor.constraint(equalTo: self.safeGuide.widthAnchor, multiplier: 0.2).isActive = true
        //        self.sequence.leadingAnchor.constraint(equalTo: self.safeGuide.leadingAnchor).isActive = true
        //        self.sequence.topAnchor.constraint(equalTo: self.safeGuide.topAnchor).isActive = true
        //        self.sequence.bottomAnchor.constraint(equalTo: self.marginGuide.bottomAnchor).isActive = true
        //
        //        // Layout of view controllers' name
        //        self.viewControllerName.widthAnchor.constraint(equalTo: self.safeGuide.widthAnchor, multiplier: 0.5).isActive = true
        //        self.viewControllerName.trailingAnchor.constraint(equalTo: self.safeGuide.trailingAnchor).isActive = true
        //        self.viewControllerName.topAnchor.constraint(equalTo: self.safeGuide.topAnchor).isActive = true
        //        self.viewControllerName.bottomAnchor.constraint(equalTo: self.safeGuide.bottomAnchor).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
