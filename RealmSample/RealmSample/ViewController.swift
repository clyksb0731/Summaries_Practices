//
//  ViewController.swift
//  RealmSample
//
//  Created by Yongseok Choi on 10/06/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("will instantiate the first realm")
        
        self.realmTestOnSerialQueue()
    }


}

// MARK: Extension for methods added
extension ViewController {
    func realmTestOnSerialQueue() {
        let serialQueue = DispatchQueue(label: "serialQueue")
        
        serialQueue.async {
            do {
                let realm = try Realm()
                print("did instantiate first Realm")
                self.realmTestOnConcurrentQueue()
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func realmTestOnConcurrentQueue() {
        print("will instantiate second Realm")
        let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
        
        concurrentQueue.async {
            do {
                let realm = try Realm()
                
                let table = Table()
                
                try realm.write {
                    realm.add(table)
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            print("did instantiate second Realm")
        }
    }
}

