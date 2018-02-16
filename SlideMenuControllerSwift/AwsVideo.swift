//
//  AwsVideo.swift
//  Broadkazt
//
//  Created by Jeevan Sivagnanasuntharam on 10/10/2017.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import Foundation
import SwiftyJSON

class AwsVideo {
    let videoName              :String!
    let description            :String!
    let thumbnail              :String!
    let status                 :String!
    let language               :String!
    let awsUrl                 :String!
    let duration               :Int!
    var logo                     :String!
    
    
    required init(parameter: JSON) {
        videoName            = parameter["videoName"].stringValue
        description          = parameter["description"].stringValue
        thumbnail            = parameter["thumbnail"].stringValue
        status               = parameter["status"].stringValue
        language             = parameter["language"].stringValue
        awsUrl               = parameter["awsUrl"].stringValue
        duration             = parameter["duration"].intValue
        //logo                 = parameter["logo"].stringValue
}
}
