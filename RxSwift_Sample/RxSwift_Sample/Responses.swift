//
//  Responses.swift
//  RxSwift_Sample
//
//  Created by Yongseok Choi on 16/07/2019.
//  Copyright © 2019 Yongseok Choi. All rights reserved.
//

import Foundation

struct ReturnedData: Codable {
    var id: String
    var contentValue: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case contentValue = "content_value"
    }
}
