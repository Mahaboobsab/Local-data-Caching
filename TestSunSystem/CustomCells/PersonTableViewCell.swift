//
//  PersonTableViewCell.swift
//  TestSunSystem
//
//  Created by Nadaf on 28/01/19.
//  Copyright © 2019 Nadaf. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        
        self.profileImage.clipsToBounds = true
    }
    
    func configureCell(person : Person)  {
        
        self.firstName.text = person.firstName
        self.lastName.text = person.lastName
        self.email.text = person.emailId
        
        //  GCD to download image Asynchronously
        
        let queue = DispatchQueue.global(qos: .default)
        
        queue.async() { () -> Void in
            
            let img1 = Downloader.downloadImageWithURL(url: person.imageUrl ?? "")
            DispatchQueue.main.async {
                self.profileImage.image = img1
            }
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


// MARK:  Image Downloader

class Downloader {
    
    class func downloadImageWithURL(url:String) -> UIImage! {
        
        let data = NSData(contentsOf: NSURL(string: url)! as URL)
        
        if let imageData = data {
            return UIImage(data: imageData as Data)
        }
        else{
            
            
            //TODO: Change placeholder image
            
            return UIImage.init(named: "placeHolder.png")
            
        }
    }
}

