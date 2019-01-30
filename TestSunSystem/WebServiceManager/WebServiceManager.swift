//
//  WebServiceManager.swift
//  TestSunSystem
//
//  Created by Nadaf on 28/01/19.
//  Copyright © 2019 Nadaf. All rights reserved.
//

import UIKit
import Alamofire
class WebServiceManager: NSObject {
    
    static var sharedInstance = WebServiceManager()
    
    private override init() {
        
    }
    
    
    
    func postRequestWithEndpoint(endpoint : String, parameters : Parameters ,headers : HTTPHeaders, onFinished: @escaping ( _ error:String?,  _ user: Any?) -> ())  {
        
        Alamofire.request(endpoint, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                if let result = response.result.value {
                    
                    onFinished(nil, result)
                }else{
                    onFinished("Something went wrong", nil)
                }
                
                break
            case .failure(let error):
                
                onFinished(error.localizedDescription, nil)
                
                print(error)
            }
        }
        
        
    }
    
    
    
    func getRequestWithHeadersEndpoint(endpoint : String ,headers : HTTPHeaders,onFinished: @escaping ( _ error:String?,  _ user: Any?) -> ())  {
        
        
        
        Alamofire.request(endpoint, method: .get, parameters: nil,encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                if let result = response.result.value {
                    
                    onFinished(nil, result)
                }else{
                    onFinished("Something went wrong", nil)
                }
                
                break
            case .failure(let error):
                
                onFinished("Something went wrong", nil)
                
                print(error)
            }
        }
        
        
}
}
