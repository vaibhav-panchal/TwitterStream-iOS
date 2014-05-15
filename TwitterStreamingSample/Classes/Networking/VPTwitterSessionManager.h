//
//  VPTwitterSessionManager.h
//  TwitterStreamingSample
//
//  Created by Vaibhav Panchal on 06/04/2014.
//  Copyright (c) 2014 Vebz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPTwitterSessionDelegate.h"

/**
 @class VPTwitterSessionManager
 
 VPTwitterSessionManager manages the streaming session between Twitter Public Streaming API
 and the front end. 
 
 It expected a Twitter signed URLRequest which is authenticated by SL Social Framework (can be created via SLRequest requestForServiceType method).
 */
@interface VPTwitterSessionManager : NSObject <NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) id<VPTwitterSessionDelegate> delegate;

/**
 This method "must" be used to initialize the session manager with twitter authenticated url request and a NSURLSession configurations available in the foundation framework.
 This meethod does "not" start the session. A separate call to startSession method needs to be called.
 @param URLRequest It is a twitter authenticated urlRequest
 @param configuration It is a session configuration which allows this service to be run in the backend / frontend or in upcoming different profiles.
 */
- (id) initWithNSURLRequest : (NSURLRequest *)urlRequest
           andSessionConfig : (NSURLSessionConfiguration *)configuration;

/**
 This method begins or resumes the session between twitter streaming API and the client.
 In case the connection is dropped, this method can be reinvoked.
 */
- (void)startSession;

@end
