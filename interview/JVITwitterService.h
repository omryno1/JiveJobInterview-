//
// Created by ShaLi Shaltiel on 03/02/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JVITweet;

@interface JVITwitterService : NSObject

+(instancetype)sharedService;

-(void)getHomeTimelineWithSuccess:(void (^)(NSArray<JVITweet *> *))success failed:(void (^)(NSError *))failure;

@end
