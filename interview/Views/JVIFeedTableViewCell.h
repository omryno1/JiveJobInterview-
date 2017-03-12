//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JVITweet;


@interface JVIFeedTableViewCell : UITableViewCell

-(void)updateData:(JVITweet *)tweet TableView:(UITableView *)tableView;

+(CGFloat)heightForWidth:(CGFloat)width Text:(NSString*)tweetText;

+(NSString *)cellIdentifier;

@end
