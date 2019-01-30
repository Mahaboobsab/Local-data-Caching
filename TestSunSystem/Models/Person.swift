//
//  Person.swift
//  TestSunSystem
//
//  Created by Nadaf on 28/01/19.
//  Copyright © 2019 Nadaf. All rights reserved.
//

import UIKit

class Person: NSObject {

    var emailId:String?
    var lastName:String?
    var imageUrl:String?
    var firstName:String?
    
    override init() {
        super.init()
        self.emailId = String()
        self.lastName = String()
        self.imageUrl = String()
        self.firstName = String()
    }
    
}
