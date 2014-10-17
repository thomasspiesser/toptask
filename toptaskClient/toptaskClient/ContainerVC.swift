//
//  ContainerVC.swift
//  toptaskClient
//
//  Created by Thomas Spiesser on 16.10.14.
//  Copyright (c) 2014 Thomas Spiesser. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    
    let SegueIdentifierFirst = "embedCurrentTaskTable"
    let SegueIdentifierSecond = "embedTopTaskTable"
    var currentSegueIdentifier: NSString?
    
    var taskItems: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentSegueIdentifier = SegueIdentifierFirst
        //performSegueWithIdentifier(currentSegueIdentifier, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let destVC = segue.destinationViewController as UIViewController
        if (segue.identifier == SegueIdentifierFirst) {
            var tblVC = destVC as CurrentTasksTableVC
            tblVC.taskItems = taskItems
            if (self.childViewControllers.count > 0) {
                self.swapFromViewController(self.childViewControllers[0] as UIViewController, toViewController: destVC)
            }
            else {
                self.addChildViewController(destVC)
                destVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                self.view.addSubview(destVC.view)
                destVC.didMoveToParentViewController(self)
            }
        }
        else if (segue.identifier == SegueIdentifierSecond) {
            var tblVC = destVC as TopTasksTableVC
            tblVC.taskItems = taskItems
            self.swapFromViewController(self.childViewControllers[0] as UIViewController, toViewController: destVC)
        }
    }
    
    func swapFromViewController(fromViewController: UIViewController, toViewController: UIViewController) {
        toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        fromViewController.willMoveToParentViewController(nil)
        self.addChildViewController(toViewController)
        self.transitionFromViewController(
            fromViewController,
            toViewController: toViewController,
            duration:0.2,
            options:UIViewAnimationOptions.TransitionCrossDissolve,
            animations:nil,
            completion: { finished in
                fromViewController.removeFromParentViewController()
                toViewController.didMoveToParentViewController(self)
            }
        )
    }
    
//    func swapViewControllers() {
//        self.currentSegueIdentifier = (self.currentSegueIdentifier == SegueIdentifierFirst) ? SegueIdentifierSecond : SegueIdentifierFirst
//        self.performSegueWithIdentifier(self.currentSegueIdentifier, sender:nil)
//    }
}
