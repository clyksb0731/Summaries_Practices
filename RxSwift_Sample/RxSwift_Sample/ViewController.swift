//
//  ViewController.swift
//  RxSwift_Sample
//
//  Created by Yongseok Choi on 11/07/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var asyncCheckLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var tableView = UITableView()
    var cities = ["Seoul", "Daejeon"]
    
    var disposeBag = DisposeBag()
    
    var testObservable: Observable<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func bindUI() {
       self.testStringObservable()
//        .filter {$0 == "Two"}
        .bind(to: self.notificationLabel.rx.text)
        .disposed(by: self.disposeBag)        
    }
    
    func testStringObservable() -> Observable<String> {
        return Observable.create { (observer) -> Disposable in
            var flag: Bool = false
            
            DispatchQueue.global().async {
                for index in 1...10_000 {
                    DispatchQueue.main.sync { [weak self] in
                        self?.asyncCheckLabel.text = String(index)
                    }
                    
                    if flag {
                        break
                    }
                }
                observer.onNext("AfterAsync")
                observer.onCompleted()
            }
            
            observer.onNext("One")
            observer.onNext("Two")
            observer.onNext("Three")
            
            return Disposables.create {
                flag = true
            }
        }
    }
    
    @IBAction func checkAsyncButton(_ sender: UIButton) {
        self.bindUI()
    }
    
    @IBAction func stopBinding(_ sender: Any) {
        self.disposeBag = DisposeBag()
    }
}

