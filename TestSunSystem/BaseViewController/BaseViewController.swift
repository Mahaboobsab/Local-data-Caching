//
//  BaseViewController.swift
//  TestSunSystem
//
//  Created by Nadaf on 28/01/19.
//  Copyright © 2019 Nadaf. All rights reserved.
//

import SVProgressHUD
import Alamofire


class BaseViewController: UIViewController {
    
    
    func showActivityIndicatorWithMessage(message : String)  {
        SVProgressHUD.show(withStatus: message)
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    func stopActivityIndicator() {
        SVProgressHUD.dismiss()
    }
    
    
    func showAlertMessage(_ msg: String?, title: String?, ok okTitle: String?, cancel cancelTitle: String?) {
        let controller = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        
        if okTitle != nil {
            let ok = UIAlertAction(title: okTitle, style: .default, handler: {(_ action: UIAlertAction?) -> Void in
                self.okButtonClicked()
            })
            controller.addAction(ok)
        } else {
            
            
        }
        
        if cancelTitle != nil {
            let cancel = UIAlertAction(title: cancelTitle, style: .default, handler: {(_ action: UIAlertAction?) -> Void in
                self.cancelButtonClicked()
            })
            controller.addAction(cancel)
        } else {
            // NSLog(@"nil");
        }
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.present(controller, animated: true) {() -> Void in }
        })
    }
    
    func okButtonClicked()  {
        
    }
    
    func cancelButtonClicked()  {
        
    }
    
}
