//
//  PersonVC.swift
//  TestSunSystem
//
//  Created by Nadaf on 28/01/19.
//  Copyright © 2019 Nadaf. All rights reserved.
//

import UIKit

class PersonVC: BaseViewController {
    
    @IBOutlet weak var personTableView: UITableView!
    
    
    var person:[Person] = [Person]()
    
    
    override func viewDidLoad() {
        
        
        //Fetching cached data
        
        if let persons = UserDefaults.standard.value(forKey: "personsList") {
            
            
            let dataArray = NSKeyedUnarchiver.unarchiveObject(with: persons  as! Data)
            
            
            if dataArray != nil{
                
                self.loadViewUsingArray(array: dataArray as! NSArray)
            }
        }
        
        
        self.getPersonListAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    
    // MARK: Web Service
    
    func getPersonListAPI()  {
        
        if self.person.count == 0{
            self.showActivityIndicatorWithMessage(message: NSLocalizedString("Loading", comment: ""))
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        WebServiceManager.sharedInstance.postRequestWithEndpoint(endpoint: Utilities.baseUrl(withEndPoints: Constats.kList_API)!, parameters: ["emailId" : "mrnadaf2010@gmail.com"], headers: [:]) { (error, response) in
            self.stopActivityIndicator()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let loadError =  error{
                
                
                self.showAlertMessage(error, title: NSLocalizedString("Error_Title", comment: ""), ok: NSLocalizedString("OK_Title", comment: ""), cancel: nil)
                
                print(loadError)
                
                
            }else if let personsArray = response{
                
                
                
                let JSON = (personsArray as! NSDictionary).value(forKey: "items")as! NSArray
                
                
                self.loadViewUsingArray(array: JSON)
                
                
                
                //Cache data locally
                
                let data = NSKeyedArchiver.archivedData(withRootObject: JSON)
                
                UserDefaults.standard.set(data, forKey: "personsList")
                UserDefaults.standard.synchronize()
                
                
                self.personTableView.reloadData()
            }
        }
    }
    
    
    
    func loadViewUsingArray(array: NSArray)  {
        
        var persons = [Person]()
        var person = Person()
        
        let JSON = array
        
        for i in JSON{
            
            person = Person()
            
            if let obj = i as? NSDictionary{
                
                if let email = obj["emailId"] as? String{
                    person.emailId = email
                }
                
                if let lastName =  obj["lastName"] as? String{
                    
                    person.lastName = lastName
                }
                if let firstName = obj["firstName"] as? String{
                    
                    person.firstName = firstName
                }
                if let image = obj["imageUrl"] as? String{
                    
                    person.imageUrl = image
                }
                
            }
            persons.append(person)
        }
        self.person = persons
        print(self.person)
        
        self.personTableView.reloadData()
    }
    
}

// MARK: TableView Datasource

extension PersonVC : UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.person.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "PersonTableViewCell"
        
        let cell : PersonTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PersonTableViewCell
        
        cell.configureCell(person:self.person[indexPath.row])
        
        return cell
        
    }
    
}
