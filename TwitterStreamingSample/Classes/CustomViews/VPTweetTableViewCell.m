//
//  VPTweetTableViewCell.m
//  TwitterStreamingSample
//
//  Created by Vaibhav Panchal on 06/04/2014.
//  Copyright (c) 2014 Vebz. All rights reserved.
//

#import "VPTweetTableViewCell.h"
#import "VPTwitterUtilities.h"

@implementation VPTweetTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCellWithVPTwitterFeedModel : (VPTwitterFeedModel *)tweetModel
{
    NSParameterAssert(tweetModel);
    NSAssert(tweetModel.tweetText, @"Invalid tweet text");
    NSAssert(tweetModel.tweetUserScreenName, @"Invalid tweet screen name");
    NSAssert(tweetModel.createdDate, @"Invalid created date");
    NSAssert(tweetModel.favouriteCounts, @"Invalid favourite counts");

    NSLog(@"%@", tweetModel.tweetText);
    NSLog(@"%@", tweetModel.tweetUserScreenName);
    NSLog(@"%@", tweetModel.createdDate);
    NSLog(@"%@", tweetModel.favouriteCounts);
    
    _tweetText.text = tweetModel.tweetText;
    _tweetUserScreenName.text = tweetModel.tweetUserScreenName;
    
    NSString *createdDateText = [VPTwitterUtilities convertTwitterCreatedDateToFormattedStringFrom:tweetModel.createdDate];
    
    _createdDate.text = createdDateText;
    
    _favouriteCounts.text = tweetModel.favouriteCounts;

    if (![tweetModel.profileImageURL isEqualToString:@""]) {
        NSURL *profileURL = [NSURL URLWithString:tweetModel.profileImageURL];
        [_userProfileImage setImageWithURL:profileURL];
    }
    
}

@end
