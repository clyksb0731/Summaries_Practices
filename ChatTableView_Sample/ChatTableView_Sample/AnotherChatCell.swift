//
//  AnotherChatCell.swift
//  ChatTableView_Sample
//
//  Created by 최용석 on 04/10/2018.
//  Copyright © 2018 최용석. All rights reserved.
//

import UIKit

class AnotherChatCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let tmpLabel = UILabel()
        let marginGuide = self.contentView
        
        tmpLabel.backgroundColor = .yellow
        tmpLabel.text = "Your"
        tmpLabel.font = UIFont.systemFont(ofSize: 15)
        tmpLabel.textColor = .black
        tmpLabel.textAlignment = .center
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(tmpLabel)
        
        tmpLabel.widthAnchor.constraint(equalTo: marginGuide.widthAnchor, multiplier: 0.5).isActive = true
        tmpLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        tmpLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        tmpLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
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
