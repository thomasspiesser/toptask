//
//  FavouritesVC.swift
//  toptaskClient
//
//  Created by Thomas Spiesser on 19.09.14.
//  Copyright (c) 2014 Thomas Spiesser. All rights reserved.
//

import UIKit

class FavouritesVC: UIViewController {
    
    @IBOutlet weak var Task1: UIButton!
    @IBOutlet weak var Task2: UIButton!
    @IBOutlet weak var Task3: UIButton!
    @IBOutlet weak var Task4: UIButton!
    
    var meteor:MeteorClient!
    var userId:NSString!
    //var lists:NSMutableArray!
    
    var containerVC: ContainerVC?
    
    var taskItems: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSomeData() {
        var item1 = TaskItem(name: "milk", checkCount: 3)
        self.taskItems.addObject(item1)
        var item2 = TaskItem(name: "eggses", checkCount: 2)
        self.taskItems.addObject(item2)
        var item3 = TaskItem(name: "honey", checkCount: 1)
        self.taskItems.addObject(item3)
    }

    func loadSomeOtherData() {
        var item1 = TaskItem(name: "milkyway", checkCount: 2)
        self.taskItems.addObject(item1)
        var item2 = TaskItem(name: "eggsalat", checkCount: 3)
        self.taskItems.addObject(item2)
        var item3 = TaskItem(name: "honeybear", checkCount: 1)
        self.taskItems.addObject(item3)
    }
    
    @IBAction func didTapTask2Button(sender: AnyObject) {
        self.taskItems.removeAllObjects()
        loadSomeData()
//        tblVC.taskItems = taskItems
//        tblVC.tableView.reloadData()
//        tblVC.tableView.hidden = false
        
        self.containerVC?.taskItems = taskItems
        self.showCurrentList()
    }
    
    @IBAction func didLongPressTask2Button(sender: UILongPressGestureRecognizer) {
        if sender.state == .Ended {
            self.taskItems.removeAllObjects()
            loadSomeData()
            self.containerVC?.taskItems = taskItems
            self.showTopList()
        }
    }

    @IBAction func didTapTask4Button(sender: AnyObject) {
        self.taskItems.removeAllObjects()
        loadSomeOtherData()
        
        self.containerVC?.taskItems = taskItems
        self.showCurrentList()
    }
    
    @IBAction func didLongPressTask4Button(sender: UILongPressGestureRecognizer) {
        if sender.state == .Ended {
            self.taskItems.removeAllObjects()
            loadSomeOtherData()
            self.containerVC?.taskItems = taskItems
            self.showTopList()
        }
    }
    
    func showCurrentList() {
        self.containerVC?.performSegueWithIdentifier("embedCurrentTaskTable", sender: nil)
    }
    
    func showTopList() {
        self.containerVC?.performSegueWithIdentifier("embedTopTaskTable", sender: nil)
        
    }
    
//    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
//        var tblVC = self.childViewControllers[0] as CurrentTasksTableVC
//        tblVC.tableView.hidden = true
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "EmbedTables") {
            self.containerVC = segue.destinationViewController as? ContainerVC
        }
    }

}
