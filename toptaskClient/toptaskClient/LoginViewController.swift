//
//  LoginViewController.swift
//  toptaskClient
//
//  Created by Thomas Spiesser on 18.09.14.
//  Copyright (c) 2014 Thomas Spiesser. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var connectionStatusText: UILabel!
    @IBOutlet weak var connectionStatusLight: UIImageView!
    
    var meteor:MeteorClient!
    
    override func viewWillAppear(animated: Bool) {
        var observingOption = NSKeyValueObservingOptions.New
        meteor.addObserver(self, forKeyPath:"websocketReady", options: observingOption, context:nil)
    }
    
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [NSObject : AnyObject]!, context: UnsafeMutablePointer<()>) {
        
        if (keyPath == "websocketReady" && meteor.websocketReady) {
            connectionStatusText.text = "Connected to Todo Server"
            var image:UIImage = UIImage(named: "green_light.png")
            connectionStatusLight.image = image
        }
    }
    
    @IBAction func tappedLoginButton(sender: AnyObject) {
        if (!meteor.websocketReady) {
            let notConnectedAlert = UIAlertView(title: "Connection Error", message: "Can't find the TopTask server, try again", delegate: nil, cancelButtonTitle: "OK")
            notConnectedAlert.show()
            return
        }
        println("tapped button")
        println(self.username.text)
        
        
        meteor.logonWithEmail(self.username.text, password: self.password.text, responseCallback: {(response, error) -> Void in
            
            if((error) != nil) {
                self.handleFailedAuth(error)
                return
            }
            self.handleSuccessfulAuth()
        })
    }
    
    func handleSuccessfulAuth() {
        println("success")
        
        println(self.meteor.userId)
        
        //var listViewController = ListViewController(nibName: "ListViewController", bundle: nil, meteor: self.meteor)
        var favsViewController = FavouritesViewController(nibName: "FavouritesViewController", bundle: nil, meteor: self.meteor)
        
        
        favsViewController.userId = self.meteor.userId
        self.navigationController.pushViewController(favsViewController, animated: true)
    }
    
    func handleFailedAuth(error: NSError) {
        println("failed")
        UIAlertView(title: "TopTask", message:error.localizedDescription, delegate: nil, cancelButtonTitle: "Try Again").show()
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