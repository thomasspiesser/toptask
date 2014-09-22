//
//  FavouritesViewController.swift
//  toptaskClient
//
//  Created by Thomas Spiesser on 19.09.14.
//  Copyright (c) 2014 Thomas Spiesser. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var Task1: UIButton!
    @IBOutlet weak var Task2: UIButton!
    @IBOutlet weak var Task3: UIButton!
    @IBOutlet weak var Task4: UIButton!
    
    var meteor:MeteorClient!
    var userId:NSString?
    //var lists:NSMutableArray!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!, meteor: MeteorClient!) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.meteor = meteor
        //self.lists = self.meteor.collections["lists"] as NSMutableArray

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}