//
//  VPTweetTableViewCell.h
//  TwitterStreamingSample
//
//  Created by Vaibhav Panchal on 06/04/2014.
//  Copyright (c) 2014 Vebz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VPTwitterFeedModel.h"
#import "UIImageView+WebCache.h"

/**
 This cell configures the Tweet prototype cell in the Main.storyboard library. 
 It is intelligent to layout its subviews from VPTwitterFeelModel.
 */
@interface VPTweetTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UITextView *tweetText; /// The main tweet text tweeted by the user
@property (nonatomic, strong) IBOutlet UILabel *tweetUserScreenName; /// User screen name (which is different than the username)
@property (nonatomic, strong) IBOutlet UILabel *createdDate; /// The date when twitter was created. This is in "EEE LLL d HH:mm:ss Z yyyy" format  and is converted by the utility.
@property (nonatomic, strong) IBOutlet UILabel *favouriteCounts; /// The number of times the tweet has been favourtied.
@property (nonatomic, strong) IBOutlet UIImageView *userProfileImage; /// User's profile image via https link.

/**
 This function is used to layout the subviews of the cell based on the model information.
 @param TweetModel contains the information which is displayed in this cell.
 */
-(void) setCellWithVPTwitterFeedModel : (VPTwitterFeedModel *)tweetModel;

@end
