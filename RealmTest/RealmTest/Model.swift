//
//  Model.swift
//  RealmTest
//
//  Created by 최용석 on 29/11/2018.
//  Copyright © 2018 최용석. All rights reserved.
//

import Foundation
import RealmSwift

class Temp: Object {
    @objc dynamic var one: String = ""
    @objc dynamic var two: String = ""
    
    convenience init (one: String, two: String) {
        self.init()
        
        self.one = one
        self.two = two
    }
    
    override static func primaryKey() -> String {
        return "one"
    }
}
