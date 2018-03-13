//
//  UIViewController+Features.swift
//  Broadkazt
//
//  Created by Ikarma Khan on 24/12/2017.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAPIResponseError (message:String) {
        
        let alertController = UIAlertController.init(title: "Error", message: message, preferredStyle:UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}


