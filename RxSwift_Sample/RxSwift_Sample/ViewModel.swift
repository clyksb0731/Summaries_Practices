//
//  ViewModel.swift
//  RxSwift_Sample
//
//  Created by Yongseok Choi on 16/07/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel {
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    func requestAPI(url: URL, parameter: [String:Any], method: HTTPMethod) -> Observable<Data?> {
        return Observable.create({ (observer) -> Disposable in
            let defaultSession = URLSession(configuration: .default)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
            
            let dataTask = defaultSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                if let error = error {
                    observer.onError(error)
                }
                
                if let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    observer.onNext(data)
                }
                
                observer.onCompleted()                
            })
            
            dataTask.resume()
            
            return Disposables.create {
                dataTask.cancel()
            }
        })
    }
}
