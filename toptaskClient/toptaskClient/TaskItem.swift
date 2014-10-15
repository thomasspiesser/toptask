//
//  TaskItem.swift
//  toptaskClient
//
//  Created by Thomas Spiesser on 14.10.14.
//  Copyright (c) 2014 Thomas Spiesser. All rights reserved.
//

import UIKit

class TaskItem: NSObject {
    var taskName: NSString = ""
    var checked: Bool = false
    var checkCount: Int = 0
    var creationDate: NSDate = NSDate()
    
    init(name:String){
        self.taskName = name
    }
}
