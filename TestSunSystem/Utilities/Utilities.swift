//
//  Utilities.swift
//  TestSunSystem
//
//  Created by Nadaf on 28/01/19.
//  Copyright © 2019 Nadaf. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    class func baseUrl(withEndPoints endPoint: String?) -> String? {
        
        let maindict :NSDictionary = Bundle.main.infoDictionary! as NSDictionary
        
        let strinew:NSDictionary = maindict["DEVELOPMENT"] as! NSDictionary
        let strneadd = strinew.object(forKey: "BaseUrl") as! String
        
        return "\(strneadd )\(endPoint ?? "")"
        
        
    }
    
    class func validateEmail(_ email: String?) -> Bool {
        let emailRegex = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}
