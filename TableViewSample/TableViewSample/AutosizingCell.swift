//
//  autosizingCell.swift
//  TableViewSample
//
//  Created by 최용석 on 28/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit

class AutosizingCell: UITableViewCell {
    
    var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.borderWidth = 1
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.backgroundColor = UIColor.clear.cgColor
        
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
extension AutosizingCell {
    func setViewFoundation() {
        
    }
    
    /**
     */
    func setSubviews() {
        self.contentView.addSubview(self.view)
        self.view.addSubview(self.label)
    }
    
    /**
     */
    func setLayouts() {
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.view.bottomAnchor.constraint(greaterThanOrEqualTo: self.contentView.bottomAnchor, constant: -10),
            self.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.label.bottomAnchor.constraint(greaterThanOrEqualTo: self.view.bottomAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 200),
            self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
            ])
    }
}
