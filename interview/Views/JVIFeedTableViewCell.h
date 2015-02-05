//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JVITweet;


@interface JVIFeedTableViewCell : UITableViewCell

- (void)updateData:(JVITweet *)tweet;

+ (CGFloat)heightForWidth:(CGFloat)width Text:(NSString*)tweetText;

@end