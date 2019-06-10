//
//  RealmDB.swift
//  RealmSample
//
//  Created by Yongseok Choi on 10/06/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Table: Object {
    dynamic var name: String = ""
    dynamic var age: Int = 0
    dynamic var home: String = ""
    dynamic var tall: Double = 0.0
    dynamic var mass: Double = 0.0
}
