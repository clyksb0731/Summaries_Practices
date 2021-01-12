//
//  CustomCell.swift
//  TableViewMovableCell
//
//  Created by Yongseok Choi on 2020/12/18.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.label)
        
        let safeArea = self.contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.label.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.label.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            self.label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            self.label.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
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
    
    func setCell(_ text:String) {
        self.label.text = text
    }
}
