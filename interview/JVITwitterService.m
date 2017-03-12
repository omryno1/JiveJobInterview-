//
// Created by ShaLi Shaltiel on 03/02/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <STTwitter/STTwitterAPI.h>
#import "JVITwitterService.h"
#import "JVITweet.h"

@interface JVITwitterService()

@property (strong, nonatomic) STTwitterAPI *twitter;

@end

@implementation JVITwitterService

static JVITwitterService *sharedService;

+(void)initialize {
    sharedService = [[JVITwitterService alloc] init];
}

+(instancetype)sharedService {
    return sharedService;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:@"kFJ064pfvcmT0EY29ziupHFSV"
                                                 consumerSecret:@"xVLfhefQg5Oft5vglxutIhq8XfTc5Nzx0RDoulJUGDmjoPrGq3"
                                                     oauthToken:@"3009035432-3e3A46Oyrgw6FJvZ1fHixLbxhkRCawgha1zLVPo"
                                               oauthTokenSecret:@"GMeSZWGT4dwxKGJEEqhEmOEtndioN7c17iOT77mvq4GOV"];
    }
    return self;
}



-(void)getHomeTimelineWithSuccess:(void (^)(NSArray<JVITweet *> *))success TweetID:(NSString *)tweetID failed:(void (^)(NSError *))failure{
    [self.twitter getStatusesHomeTimelineWithCount:@"10" sinceID:nil maxID:tweetID trimUser:nil excludeReplies:nil contributorDetails:nil includeEntities:nil successBlock:^(NSArray *statuses) {
//    [self.twitter getHomeTimelineSinceID:nil count:10 successBlock:^(NSArray *statuses) {
        NSLog(@"%@",statuses);
        NSMutableArray<JVITweet *> *list = [[NSMutableArray alloc] init];
        for (NSDictionary *statusDict in statuses) {
            [list addObject:[[JVITweet alloc] initWithDictionary:statusDict error:nil]];
        }
        
        if (success) {
            success(list);
        }
    
    } errorBlock:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

@end
