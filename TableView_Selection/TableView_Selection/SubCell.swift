//
//  SubCell.swift
//  TableView_Selection
//
//  Created by Yongseok Choi on 12/06/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit

class SubCell: UITableViewCell {
    
    var contentLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.instantiateObjects()
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

// Extension for methods added
extension SubCell {
    // MARK: Set header
    func setCell(content: String) {
        self.contentLabel.text = content
    }
    
    // MARK: Instantiate objects
    func instantiateObjects() {
        self.contentLabel = {
            let title = UILabel()
            title.textColor = .black
            title.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            title.numberOfLines = 0
            title.translatesAutoresizingMaskIntoConstraints = false
            
            return title
        }()
    }
    
    // MARK: Set subviews
    func setSubviews() {
        self.addSubview([
            self.contentLabel
            ], to: self.contentView)
    }
    
    // MARK: Set layouts
    func setLayouts() {
        let safeArea = self.contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.contentLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            self.contentLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            self.contentLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            self.contentLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            self.contentLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
            ])
    }
    
    func addSubview(_ views: [UIView], to: UIView) {
        for view in views {
            to.addSubview(view)
        }
    }
}
