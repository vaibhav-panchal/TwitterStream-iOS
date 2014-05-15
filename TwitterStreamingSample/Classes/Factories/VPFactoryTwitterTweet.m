//
//  VPFactoryTwitterTweet.m
//  TwitterStreamingSample
//
//  Created by Vaibhav Panchal on 06/04/2014.
//  Copyright (c) 2014 Vebz. All rights reserved.
//

#import "VPFactoryTwitterTweet.h"


@implementation VPFactoryTwitterTweet

+(VPTwitterFeedModel *) CreateVPTwitterFeedModelsFromJsonData : (id) jsonData
{
    NSParameterAssert(jsonData);

    VPTwitterFeedModel *tweet = nil;
    
    if([jsonData isKindOfClass:[NSDictionary class]])
    {
        
        NSDictionary *jsonDictionary = (NSDictionary *)jsonData;
        NSDictionary *user = [jsonDictionary objectForKey:@"user"];
        
        NSString *tweetText = [jsonDictionary objectForKey:@"text"];
        NSString *userScreenName = [user objectForKey:@"screen_name"];
        NSString *createdDate = [jsonDictionary objectForKey:@"created_at"];
        NSNumber *favouriteCounts = [jsonDictionary objectForKey:@"favorite_count"];
        NSString *favouriteCountString = [favouriteCounts stringValue];
        NSString *userProfileImageURL = [user objectForKey:@"profile_image_url_https"];
        
        tweet = [[VPTwitterFeedModel alloc] initWithUserScreenName:userScreenName
                                                         TweetText:tweetText
                                                       CreatedDate:createdDate
                                                   FavouriteCounts:favouriteCountString
                                                   ProfileImageURL:userProfileImageURL];
        
    }
    
    return tweet;
}

@end
