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



-(void)getHomeTimelineWithSuccess:(void (^)(NSArray<JVITweet *> *))success failed:(void (^)(NSError *))failure{
    [self.twitter getHomeTimelineSinceID:nil count:10 successBlock:^(NSArray *statuses) {
//        NSLog(@"%@",statuses);
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

-(void)loadNextPageInTimeline:(void (^)(NSArray<JVITweet *> *))success TweetID:(NSString *)tweetID failed:(void (^)(NSError *))failure{
        [self.twitter getStatusesHomeTimelineWithCount:@"10" sinceID:nil maxID:tweetID trimUser:nil excludeReplies:nil contributorDetails:nil includeEntities:nil successBlock:^(NSArray *statuses) {
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

-(void)uploadData:(NSString *) tweet TweetImage:(NSData *) data{
    
    [self.twitter postMediaUploadData:data fileName:nil uploadProgressBlock:nil successBlock:^(NSDictionary *imageDictionary, NSString *mediaID, NSInteger size) {
        
        NSLog(@"image upload succesful : %@",mediaID);
        NSArray *imageID = [NSArray arrayWithObjects:mediaID, nil];
        [self postTweet:imageID TweetText:tweet];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"Error while uploading");
    }];
    
}

-(void)postTweet:(NSArray *)mediaID TweetText:(NSString *) tweet {
    [self.twitter postStatusUpdate:tweet inReplyToStatusID:nil mediaIDs:mediaID latitude:nil longitude:nil placeID:nil displayCoordinates:nil trimUser:nil successBlock:^(NSDictionary *status) {
        
        NSLog(@"tweet posted");
        
    } errorBlock:^(NSError *error) {
        //some code
    }];
}

@end
