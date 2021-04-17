//
//  TestSubview.swift
//  SubviewTest
//
//  Created by Yongseok Choi on 2021/04/17.
//

import UIKit

class TestSubview: UIView {
    
    var removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove", for: .normal)
        button.backgroundColor = .cyan
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        
        removeButton.addTarget(self, action: #selector(removeButton(_:)), for: .touchUpInside)
        
        self.addSubview(self.removeButton)
        
        NSLayoutConstraint.activate([
            self.removeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.removeButton.heightAnchor.constraint(equalToConstant: 50),
            self.removeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.removeButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func removeButton(_ sender: UIButton) {
        self.removeFromSuperview()
    }
}
