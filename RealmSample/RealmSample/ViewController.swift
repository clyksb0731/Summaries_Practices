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
    
    var result: Results<Table>!
    var tmpResult: Results<Table>!
    var filters: Set<String> = []
    
    @IBOutlet weak var filter1Button: UIButton!
    @IBOutlet weak var filter2: UIButton!
    @IBOutlet weak var filter3Button: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        do {
            let realm = try Realm()
            
            let a = Table()
            try realm.write {
                realm.add(a)
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        do {
            let realm = try Realm()
            
            self.result = realm.objects(Table.self)
            self.tmpResult = self.result
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func filter1(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.filters.remove("first")
            
        } else {
            sender.isSelected = true
            self.filters.insert("first")
        }
    }
    
    @IBAction func filter2(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.filters.remove("second")
            
        } else {
            sender.isSelected = true
            self.filters.insert("second")
        }
    }
    
    @IBAction func filter3(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.filters.remove("third")
            
        } else {
            sender.isSelected = true
            self.filters.insert("third")
        }
    }
    
    @IBAction func applyFilters(_ sender: UIButton) {
        for filter in self.filters {
            if filter == "first" {
                self.result = self.result.filter("name == 'A'")
                
            } else if filter == "second" {
                self.result = self.result.filter("name == 'B'")
                
            } else if filter == "third" {
                self.result = self.result.filter("name == 'C'")
            }
        }
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

