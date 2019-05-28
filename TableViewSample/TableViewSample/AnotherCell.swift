//
//  anotherCell.swift
//  TableViewSample
//
//  Created by 최용석 on 28/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class AnotherCell: UITableViewCell {
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profileImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setSubviews()
        self.setLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

// MARK: Extension for methods added
extension AnotherCell {
    func setViewFoundation() {
        
    }
    
    /**
     */
    func setTargets() {
        
    }
    
    /**
     */
    func setGestures() {
        
    }
    
    /**
     */
    func setDelegates() {
        
    }
    
    /**
     */
    func setNotificationCenters() {
        
    }
    
    /**
     */
    func setSubviews() {
        self.contentView.addSubview(self.profileImageView)
    }
    
    /**
     */
    func setLayouts() {
        NSLayoutConstraint.activate([
            self.profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.profileImageView.heightAnchor.constraint(equalToConstant: 75),
            self.profileImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.profileImageView.widthAnchor.constraint(equalToConstant: 75)
            ])
    }
}
