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
    @objc dynamic var three: String = {
       return "\(self.one)\(self.two)"
    }
}
