//
//  newsFeedCollectionViewCell.swift
//  Snowcialite iOS App
//
//  Created by Justin Espejo on 10/30/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit

class newsFeedCollectionViewCell: UICollectionViewCell {
    
    //public
    var newsFeed : newsFeedTest!{
        didSet{
            updateUI()
        }
    }
    
    //private
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var newsFeedTitleLabel: UILabel!
    
    private func updateUI()
    {
        
    newsFeedTitleLabel?.text! = newsFeed.title
    featuredImageView?.image! = newsFeed.featuredImage
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 15.0
        self.clipsToBounds = true
        
    }
    
}
