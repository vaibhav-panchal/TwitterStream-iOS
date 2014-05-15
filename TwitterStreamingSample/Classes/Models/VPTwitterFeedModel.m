//
//  VPTwitterFeedModel.m
//  TwitterStreamingSample
//
//  Created by Vaibhav Panchal on 06/04/2014.
//  Copyright (c) 2014 Vebz. All rights reserved.
//

#import "VPTwitterFeedModel.h"

@implementation VPTwitterFeedModel

- (id)initWithUserScreenName : (NSString *)screenName
            TweetText : (NSString *)description
                 CreatedDate : (NSString *)tweetCreatedDate
             FavouriteCounts : (NSString *)totalFavouriteCounts
             ProfileImageURL : (NSString *)imageURL
{
    self = [super init];

    NSParameterAssert(screenName);
    NSParameterAssert(description);
    NSParameterAssert(tweetCreatedDate);
    NSParameterAssert(totalFavouriteCounts);
    NSParameterAssert(imageURL);
    
    if(self)
    {
        _tweetUserScreenName = screenName;
        _tweetText = description;
        _createdDate = tweetCreatedDate;
        _favouriteCounts = totalFavouriteCounts;
        _profileImageURL = imageURL;
    }
    
    return self;
}

@end
