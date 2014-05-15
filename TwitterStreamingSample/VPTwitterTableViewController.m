//
//  ViewController.m
//  TwitterStreamingSample
//
//  Created by Vaibhav Panchal on 01/04/2014.
//  Copyright (c) 2014 Vebz. All rights reserved.
//

#import "VPTwitterTableViewController.h"
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import "JSONKit.h"

#import "VPTweetTableViewCell.h"
#import "VPFactoryTwitterTweet.h"
#import "VPTwitterSessionManager.h"


const NSInteger TOTAL_TWEET_TABLE_SECTIONS = 1;
const NSInteger MAXIMUM_TWEETS_ALLOWED = 100;

@interface VPTwitterTableViewController ()
{
    
    VPTwitterSessionManager *sessionManager; // There is one manager per session.
    
    // TODO: Keep the latest MAXIMUM_TWEETS_ALLOWED tweets in the array. NSMutableArray is a dirty implementation.
    // Since foundation framework doesn't provide queue data structure,
    // either a custom solution needs to be written.
    // or we integrate something like CHDataStructures ( https://github.com/davedelong/CHDataStructures )
    // Due to time constaints, we would use NSMutableArray for now.
    NSMutableArray *tweets;
}

@end

@implementation VPTwitterTableViewController

#pragma mark - Memory Management
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ACAccountStore *twitterStore = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [twitterStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    // Autolayout offset.
    const NSInteger OFFSET_TABLEVIEW_TOP = 20;
    [_twitterTableView setContentInset:UIEdgeInsetsMake(OFFSET_TABLEVIEW_TOP,0,0,0)];
    
    // Get the request access from the user.
    [twitterStore requestAccessToAccountsWithType:twitterAccountType
                                   options:nil
                                completion:^(BOOL granted, NSError *error) {
                            
                         if (!granted) {
                             // The user rejected your request
                             // TODO: Need to move hard coded strings to a string file.
                             NSString *alertTitle = NSLocalizedString(@"Need Access To Twitter", @"Need Access To Twitter");
                             NSString *alertMessage = NSLocalizedString(@"This application need access to your twitter account in order to function. Please grant access.",
                                                                        @"This application need access to your twitter account in order to function. Please grant access.");
                             NSString *okayButtonTitle =  NSLocalizedString(@"OK", @"OK");
                             
                             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                                                 message:alertMessage
                                                                                delegate:nil
                                                                       cancelButtonTitle:okayButtonTitle
                                                                       otherButtonTitles:nil];
                             [alertView show];
                         }
                         else {
                             
                             // Grab the available accounts
                             NSArray *twitterAccounts = [twitterStore accountsWithAccountType:twitterAccountType];
                             
                             // For the test purposes, get the first twitter account.
                             // TODO: Create a view to select the appropiate twitter account from the list of available accounts and use the most appropiate.
                             if ([twitterAccounts count] > 0)
                             {
                                 ACAccount *account = [twitterAccounts objectAtIndex:0];
                                 
                                 // Use the first account for simplicity
                                 NSString *configFilePath = [[NSBundle mainBundle] pathForResource:@"TwitterConfiguration" ofType:@"plist"];
                                 NSMutableDictionary *configParameters = [NSDictionary dictionaryWithContentsOfFile:configFilePath];
                                 
                                 NSArray *trackFilters = [configParameters objectForKey:@"track"];
                                 NSMutableString *filter = [NSMutableString stringWithFormat:@""];
                                 for(NSString *currentTrackFilter in trackFilters)
                                 {
                                     [filter appendString:currentTrackFilter];
                                     [filter appendString:@","];
                                 }
                                 
                                 NSMutableDictionary *twitterParameters = [NSMutableDictionary dictionary];
                                 [twitterParameters setObject:filter forKey:@"track"];
                                 
                                 //  The endpoint that we wish to call
                                 NSURL *twitterURL = [NSURL URLWithString:@"https://stream.twitter.com/1/statuses/filter.json"];
                                 SLRequest *twitterRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                                requestMethod:TWRequestMethodPOST
                                                                                          URL:twitterURL
                                                                                   parameters:twitterParameters];
                                 twitterRequest.account = account;
                                 
                                 NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
                                 sessionManager = [[VPTwitterSessionManager alloc] initWithNSURLRequest:twitterRequest.preparedURLRequest
                                                                                       andSessionConfig:defaultConfig];
                                 sessionManager.delegate = self;
                                 [sessionManager startSession];
                             }
                             else
                             {
                                 NSString *alertTitle = NSLocalizedString(@"Configure Twitter", @"Configure Twitter");
                                 NSString *alertMessage = NSLocalizedString(@"Please sign in to your twitter account via iPhone settings..", @"Please sign in to your twitter account via iPhone settings.");
                                 NSString *okayButtonTitle =  NSLocalizedString(@"OK", @"OK");
                                 
                                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                                                     message:alertMessage
                                                                                    delegate:self
                                                                           cancelButtonTitle:okayButtonTitle
                                                                           otherButtonTitles:nil];
                                 [alertView show];
                             }
                         }
                                }];
    
    
    tweets = [NSMutableArray array];    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return TOTAL_TWEET_TABLE_SECTIONS;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return tweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"VPTwitterCellCustomIdentifier";
    VPTweetTableViewCell *tweetCell =  (VPTweetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    const NSInteger latestTweetIndex = tweets.count - 1 - indexPath.row; // Get the last tweet at the top.
    VPTwitterFeedModel *tweet = [tweets objectAtIndex:latestTweetIndex];
    
    if(nil != tweet &&
       [tweet isKindOfClass:[VPTwitterFeedModel class]])
    {
        [tweetCell setCellWithVPTwitterFeedModel:tweet];
    }
    
    return tweetCell;
}


#pragma mark - VPTwitterSessionDelegate

-(void) didReceiveTweetJSON : (id)jsonData
{
    VPTwitterFeedModel *newTweet = [VPFactoryTwitterTweet CreateVPTwitterFeedModelsFromJsonData:jsonData];
    if(nil != newTweet)
    {
        
        if(tweets.count > MAXIMUM_TWEETS_ALLOWED)
        {
            const NSInteger OLDEST_TWEET_INDEX = 0;
            [tweets removeObjectAtIndex:OLDEST_TWEET_INDEX];
        }
        [tweets addObject:newTweet];
        [self.twitterTableView reloadData];
    }
}


-(void) didConnectionDropped
{
    [sessionManager startSession];
}

@end
