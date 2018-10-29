//
//  StyledViewController.swift
//  HT_VCs
//
//  Created by 최용석 on 26/10/2018.
//  Copyright © 2018 최용석. All rights reserved.
//

import UIKit

struct StyledViewController {
    
    var vc: UIViewController
    var name: String
    var presentStyle: PresentStyle
    
    init(_ vc: UIViewController, name: String, presentStyle: PresentStyle) {
        self.vc = vc
        self.name = name
        self.presentStyle = presentStyle
    }
}
