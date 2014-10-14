//
//  LoginViewController.swift
//  toptaskClient
//
//  Created by Thomas Spiesser on 18.09.14.
//  Copyright (c) 2014 Thomas Spiesser. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var connectionStatusText: UILabel!
    @IBOutlet weak var connectionStatusLight: UIImageView!
    
    @IBOutlet weak var logStatus: UITextField!
    
    var meteor:MeteorClient!
    var userData:NSMutableArray!
    var lists:NSMutableArray!
    
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [NSObject : AnyObject]!, context: UnsafeMutablePointer<()>) {
        println("listener called")
        println("listener: websocketReady: ", meteor.websocketReady)
        if (keyPath == "websocketReady" && meteor.websocketReady) {
            connectionStatusText.text = "Connected to Todo server"
            var image:UIImage = UIImage(named: "green_light.png")
            connectionStatusLight.image = image
        } else {
            connectionStatusText.text = "Not connected to the server"
            var image:UIImage = UIImage(named: "red_light.png")
            connectionStatusLight.image = image
        }
    }
    
    @IBAction func tappedLoginButton(sender: AnyObject) {
        if (!meteor.websocketReady) {
            let notConnectedAlert = UIAlertView(title: "Connection Error", message: "Can't find the TopTask server, try again", delegate: nil, cancelButtonTitle: "OK")
            notConnectedAlert.show()
            return
        }
        
        meteor.logonWithEmail(self.username.text, password: self.password.text, responseCallback: {(response, error) -> Void in
            if((error) != nil) {
                UIAlertView(title: "TopTask", message:error.localizedDescription, delegate: nil, cancelButtonTitle: "Try Again").show()
                return
            }
            
            self.logStatus.text = "\(self.meteor.authState.toRaw())"
            
            let sessionToken = self.meteor.sessionToken
            NSUserDefaults.standardUserDefaults().setObject(sessionToken, forKey:"sessionToken")
            NSUserDefaults.standardUserDefaults().synchronize()

            //self.performSegueWithIdentifier("segueLogin", sender: self)
        })
    }
    
    @IBAction func tappedReconnectButton(sender: AnyObject) {
        self.meteor.reconnect()
    }
    
    @IBAction func tappedLogoutButton(sender: AnyObject) {
        self.meteor.logout()
        self.logStatus.text = "\(self.meteor.authState.toRaw())"
    }

    @IBAction func tappedDisconnectButton(sender: AnyObject) {
        self.meteor.disconnect()
    }
    
    @IBAction func tappedStatusButton(sender: AnyObject) {
        self.logStatus.text = "\(self.meteor.authState.toRaw())"
        self.userData = self.meteor.collections["users"] as? NSMutableArray
        println(self.userData?.lastObject)
        println(meteor.connected)
        self.lists = self.meteor.collections["lists"] as? NSMutableArray
        println("lists \(self.lists)")
        println("status: websocketReady: ", meteor.websocketReady)

    }
    
//    @IBAction func tappedMainScreenButton(sender: AnyObject) {
//        self.performSegueWithIdentifier("segueToMain", sender: self)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate;
        meteor = delegate.meteorClient
        
        println("observer called")
        var observingOption = NSKeyValueObservingOptions.New
        meteor.addObserver(self, forKeyPath:"websocketReady", options: observingOption, context:nil)
        println("observer: websocketReady: ", meteor.websocketReady)
        
        let barViewControllers = self.tabBarController?.viewControllers
        let fvc = barViewControllers![1] as FavouritesViewController
        fvc.meteor = self.meteor
        fvc.userId = self.meteor.userId
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
//        if (segue.identifier == "segueToMain") {
//            let navigationController = segue!.destinationViewController as UINavigationController
//            
//            let fvc = navigationController.viewControllers[0] as FavouritesViewController;
//            fvc.meteor = self.meteor
//            fvc.userId = self.meteor.userId
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
