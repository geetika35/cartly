//
//  Location0TableViewController.swift
//  cartlymilestone
//
//  Created by Garrett Andrews on 5/2/16.
//  Copyright © 2016 Geetika Batra. All rights reserved.
//

import UIKit

class Location0TableViewController: UITableViewController {
    
    var foodCartsL0 = [foodCart]()
    var row = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var i = 0
        for object in foodCartsL0 as [foodCart] {
            if object.isAtLocation == 0 {
                foodCartsL0.removeAtIndex(i)
            }
            else {
                i = i+1
            }
        }
        return foodCartsL0.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("cartCell", forIndexPath: indexPath)
        
        // Configure the cell
        let currentCart = foodCartsL0[indexPath.row]
        cell.textLabel?.text = currentCart.name
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        row = indexPath.row
        
        self.performSegueWithIdentifier("TO_FOOD_FROM_L0", sender: nil)
    }
    
    // MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "TO_FOOD_FROM_L0") {
            let vc:FoodViewController = segue.destinationViewController as! FoodViewController
            
            vc.menuString = foodCartsL0[row].name
        }
        
    }


}
