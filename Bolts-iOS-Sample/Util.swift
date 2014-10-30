//
//  Util.swift
//  Bolts-iOS-Sample
//
//  Created by Keishi Hosoba on 2014/10/30.
//  Copyright (c) 2014年 hosopy. All rights reserved.
//

class Util: NSObject {
    class func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
