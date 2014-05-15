//
//  VPTwitterUtilities.m
//  TwitterStreamingSample
//
//  Created by Vaibhav Panchal on 06/04/2014.
//  Copyright (c) 2014 Vebz. All rights reserved.
//

#import "VPTwitterUtilities.h"

@implementation VPTwitterUtilities

+(NSString *) convertTwitterCreatedDateToFormattedStringFrom : (NSString*)createdDate
{
    NSParameterAssert(createdDate);
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeStyle:NSDateFormatterFullStyle];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"EEE LLL d HH:mm:ss Z yyyy"];
    
    NSDate* convertedDate = [df dateFromString:createdDate];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setDateStyle:NSDateFormatterMediumStyle];
    
    return [df stringFromDate:convertedDate];
}

@end
