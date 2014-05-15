//
//  ViewController.h
//  TwitterStreamingSample
//
//  Created by Vaibhav Panchal on 01/04/2014.
//  Copyright (c) 2014 Vebz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPTwitterSessionDelegate.h"

/**
 VPTwitterTableViewController class takes care of controller the latest tweet rendering, interfacing with the networking libraries and storing the latest tweet models.
 This class creates a Twitter filter streaming API based on the keyworks defined in TwitterConfiguration.plist.
 */

@interface VPTwitterTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, VPTwitterSessionDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *twitterTableView;

@end
