//
//  UIApplication+Features.swift
//  Broadkazt
//
//  Created by Ikarma Khan on 24/12/2017.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
