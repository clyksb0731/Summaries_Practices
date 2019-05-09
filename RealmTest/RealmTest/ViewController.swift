//
//  ViewController.swift
//  RealmTest
//
//  Created by 최용석 on 29/11/2018.
//  Copyright © 2018 최용석. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handling Errors Using Do - Catch
        do {
            let realm = try Realm()
            let tmps = realm.objects(Temp.self)

        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        // Converting Errors to Optional Values
        let realm = try? Realm()
        let tmps = realm?.objects(Temp.self)
        
        let tmp = Temp(one: "1", two: "2")
        try? realm?.write {
            realm?.add(tmp)
        }
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }


}

