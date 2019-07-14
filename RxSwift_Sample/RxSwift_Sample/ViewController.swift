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
    
    var disposeBag = DisposeBag()
    
    var notificationRelay: BehaviorRelay = BehaviorRelay<String>(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindUI()
        self.bindRelay()        
    }
    
    func bindUI() {
        self.checkButton.rx.tap
            .subscribe(onNext: {
                self.notificationRelay.accept("Test RxSwift")
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindRelay() {
        self.notificationRelay
            .bind(to: self.notificationLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    @IBAction func checkAsyncButton(_ sender: UIButton) {
        
    }
}

