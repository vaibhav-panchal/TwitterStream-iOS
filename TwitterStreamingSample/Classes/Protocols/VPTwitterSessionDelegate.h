//
//  VPTwitterSessionDelegate.h
//  TwitterStreamingSample
//
//  Created by Vaibhav Panchal on 06/04/2014.
//  Copyright (c) 2014 Vebz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VPTwitterSessionDelegate <NSObject>

@required

/**
 This method is called when the tweet json data is received and it needs to be parsed by a factory or a library.
 */
-(void) didReceiveTweetJSON : (id)jsonData;

@optional

/**
 This method is called when the session connection drops and it needs to be restarted or resumed.
 */
-(void) didConnectionDropped;

@end
