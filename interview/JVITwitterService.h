//
// Created by ShaLi Shaltiel on 03/02/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JVITweet;

@interface JVITwitterService : NSObject

+(instancetype)sharedService;

-(void)getHomeTimelineWithSuccess:(void (^)(NSArray<JVITweet *> *))success failed:(void (^)(NSError *))failure ;

-(void)loadNextPageInTimeline:(void (^)(NSArray<JVITweet *> *))success TweetID:(NSString *)tweetID failed:(void (^)(NSError *))failure;

-(void)uploadData:(NSString *)tweet TweetImage:(NSData *) data;

-(void)postTweet:(NSArray *)mediaID TweetText:(NSString *) tweet;

@end
