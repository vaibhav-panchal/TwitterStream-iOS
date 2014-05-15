//
//  VPTwitterSessionManager.m
//  TwitterStreamingSample
//
//  Created by Vaibhav Panchal on 06/04/2014.
//  Copyright (c) 2014 Vebz. All rights reserved.
//

#import "VPTwitterSessionManager.h"
#import "JSONKit.h"
#import "VPTwitterFeedModel.h"
#import "VPFactoryTwitterTweet.h"

@interface VPTwitterSessionManager ()
{
    NSURLRequest *urlSessionRequest;
    NSURLSessionConfiguration *sessionConfig;

    NSURLSession *sessionDetails;
    NSURLSessionDataTask *dataTaskSession;
}

@end

@implementation VPTwitterSessionManager

-(id) initWithNSURLRequest : (NSURLRequest *)urlRequest
          andSessionConfig : (NSURLSessionConfiguration *)configuration
{
    NSParameterAssert(urlRequest);
    NSParameterAssert(configuration);

    self = [super init];
    
    if(self)
    {
        urlSessionRequest = urlRequest;
        sessionConfig = configuration;
        
        NSURLSession *twitterSession = [NSURLSession sessionWithConfiguration:sessionConfig
                                                                     delegate:self
                                                                delegateQueue:[NSOperationQueue mainQueue]];
        
        dataTaskSession = [twitterSession dataTaskWithRequest:urlRequest];
    }
    
    return self;
}


- (void)startSession
{
    [dataTaskSession resume];
}


- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData %lu",data.length);
    
    NSString *tweetData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSInteger intValue = [tweetData integerValue];
    
    if(intValue > 0) // Ignore this one as twitter is trying to keep the session open
    {
    }
    else
    {
        // We have a tweet. Lets create the model from the factory.
        id jsonResponse = [data objectFromJSONData];
        if(jsonResponse != nil)
        {
            if([self.delegate conformsToProtocol:@protocol(VPTwitterSessionDelegate)])
            {
                [self.delegate didReceiveTweetJSON : jsonResponse];
            }
        }
    }
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    NSLog(@"didCompleteWithError %@", error.description);
}



@end
