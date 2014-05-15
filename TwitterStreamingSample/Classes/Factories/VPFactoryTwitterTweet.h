//
//  VPFactoryTwitterTweet.h
//  TwitterStreamingSample
//
//  Created by Vaibhav Panchal on 06/04/2014.
//  Copyright (c) 2014 Vebz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPTwitterFeedModel.h"

/**
 VPFactoryTwitterTweet created the twitter feed model from various feed data.
 At the time of writing this documentation, only JSON parser is implemented.
 It takes single Tweet JSON feed as an input and churn out a valid VPTwitterFeedModel object as output.
 
 This class can be extended to get multiple tweets from different types of feeds (XML / JSON / Any other futuristic schema).
 */
@interface VPFactoryTwitterTweet : NSObject

+(VPTwitterFeedModel *) CreateVPTwitterFeedModelsFromJsonData : (id) jsonData;

@end
