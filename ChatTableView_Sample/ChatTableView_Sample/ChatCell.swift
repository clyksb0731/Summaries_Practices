//
//  ChatCell.swift
//  ChatTableView_Sample
//
//  Created by 최용석 on 04/10/2018.
//  Copyright © 2018 최용석. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    let tmpLabel = UILabel()
    
    // To programmically code
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let marginGuide = self.contentView

        tmpLabel.backgroundColor = .green
        tmpLabel.text = "Temp"
        tmpLabel.font = UIFont.systemFont(ofSize: 15)
        tmpLabel.textColor = .black
        tmpLabel.textAlignment = .center
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(tmpLabel)

        print("Anything2")

        tmpLabel.widthAnchor.constraint(equalTo: marginGuide.widthAnchor, multiplier: 0.5).isActive = true
        tmpLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        tmpLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        tmpLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // After loading Xib File and when Xib file for cell exists
    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        let marginGuide = self.contentView
//
//        tmpLabel.backgroundColor = .green
//        tmpLabel.text = "Temp"
//        tmpLabel.font = UIFont.systemFont(ofSize: 15)
//        tmpLabel.textColor = .black
//        tmpLabel.textAlignment = .center
//        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.contentView.addSubview(tmpLabel)
//
//        print("Anything2")
//
//        tmpLabel.widthAnchor.constraint(equalTo: marginGuide.widthAnchor, multiplier: 0.5).isActive = true
//        tmpLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
//        tmpLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
//        tmpLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
