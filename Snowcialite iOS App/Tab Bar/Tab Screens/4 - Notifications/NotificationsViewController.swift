//
//  NotificationsViewController.swift
//  Snowcialite iOS App
//
//  Created by Deniz Tolga Turgut on 10/12/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController
{
    //storyboard reference variables
    @IBOutlet weak var tableView: UITableView!
    
    //class variables
    var tableDataArray = ["Item 1", "Item 2"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return tableDataArray.count
    }
    
    func tableView(tableView: UITableView!,
        cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        cell.textLabel!.text = tableDataArray[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) //row clicked
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell!.setSelected(false, animated: true)
        
        dispatch_async(dispatch_get_main_queue())
            {
                self.performSegueWithIdentifier("showNextScreen", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if segue.identifier == "showNextScreen"
        {
            let vc = segue.destinationViewController as! ViewController2
            
            vc.sampleString = "This is how you set a string for a view controller before you push it!"
        }
    }
}
