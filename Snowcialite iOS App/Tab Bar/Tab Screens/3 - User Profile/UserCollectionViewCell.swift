//
//  newsFeedCollectionViewCell.swift
//  Snowcialite iOS App
//
//  Created by Justin Espejo on 10/30/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    //private
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var newsFeedTitleLabel: UILabel!
    
    private func updateUI()
    {
        
//        newsFeedTitleLabel?.text! = userProfile.title
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        
//        self.layer.cornerRadius = 10.0
//        self.clipsToBounds = true
        
    }
    
    func initWithJSONEntry(inputJson: [String: AnyObject]){
        print("init")
        self.featuredImageView.image = inputJson["profilePic"] as? UIImage
        
    }
    
}
