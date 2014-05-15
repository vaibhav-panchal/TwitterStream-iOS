//
//  VPTwitterFeedModel.h
//  TwitterStreamingSample
//
//  Created by Vaibhav Panchal on 06/04/2014.
//  Copyright (c) 2014 Vebz. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 VPTwitterFeedModel takes the relevant feed data and convert them into system type objects.
 TODO: This class can be extended to keep the complete feed in a dictionary. However, for 
 lean memory, that has been deffered.
 */
@interface VPTwitterFeedModel : NSObject

- (id)initWithUserScreenName : (NSString *)screenName
            TweetText : (NSString *)description
                 CreatedDate : (NSString *)tweetCreatedDate
             FavouriteCounts : (NSString *)totalFavouriteCounts
             ProfileImageURL : (NSString *)imageURL;

@property (nonatomic, readonly) NSString *tweetText;
@property (nonatomic, readonly) NSString *tweetUserScreenName;
@property (nonatomic, readonly) NSString *createdDate;
@property (nonatomic, readonly) NSString *favouriteCounts;
@property (nonatomic, readonly) NSString *profileImageURL;

@end
