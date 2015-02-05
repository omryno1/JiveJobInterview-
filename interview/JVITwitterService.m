//
// Created by ShaLi Shaltiel on 03/02/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <STTwitter/STTwitterAPI.h>
#import "JVITwitterService.h"
#import "JVITweet.h"


@implementation JVITwitterService {
    STTwitterAPI *_twitter;
}

static JVITwitterService *sharedService;


- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    _twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:@"kFJ064pfvcmT0EY29ziupHFSV"
                                             consumerSecret:@"xVLfhefQg5Oft5vglxutIhq8XfTc5Nzx0RDoulJUGDmjoPrGq3"
                                                 oauthToken:@"3009035432-3e3A46Oyrgw6FJvZ1fHixLbxhkRCawgha1zLVPo"
                                           oauthTokenSecret:@"GMeSZWGT4dwxKGJEEqhEmOEtndioN7c17iOT77mvq4GOV"];

    return self;
}

+ (instancetype)sharedService {
    if (!sharedService) {
        sharedService = [[JVITwitterService alloc] init];
    }

    return sharedService;
}

- (void)getHomeTimelineWithSuccess:(void (^)(NSArray *))success failed:(void (^)(NSError *))failure {
    [_twitter getHomeTimelineSinceID:nil
                               count:10
                        successBlock:^(NSArray *statuses) {

                            NSMutableArray *list = [[NSMutableArray alloc] init];
                            for (id item in statuses) {
                                [list addObject:[[JVITweet alloc] initWithDictionary:item]];
                            }
                            if (success) {
                                success(list);
                            }
                        }
                          errorBlock:^(NSError *error) {
                              if (failure) {
                                  failure(error);
                              }
                          }];

}


@end