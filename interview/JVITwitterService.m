//
// Created by ShaLi Shaltiel on 03/02/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>
#import "JVITwitterService.h"
#import "JVITweet.h"


@implementation JVITwitterService {
    AFHTTPSessionManager *_manager;
    NSString *_accessToken;


}

static JVITwitterService *sharedService;


- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    NSURL *baseUrl = [[NSURL alloc] initWithString:@"https://api.twitter.com/1.1"];
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];

    // Hard coded authentication.
    NSString *authHeader = @"OAuth oauth_consumer_key=\"DC0sePOBbQ8bYdC8r4Smg\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"1423139455\",oauth_nonce=\"1264965276\",oauth_version=\"1.0\",oauth_token=\"3009035432-LhCzEFjpkDJ91rPkDFsttcWjs6W4fIiI47iZcLY\",oauth_signature=\"kTkjVU5YfiH15UiW5nJcuQj%2FTeI%3D\"";
    [_manager.requestSerializer setValue:authHeader forHTTPHeaderField:@"Authorization"];
    return self;
}

+ (instancetype)sharedService {
    if (!sharedService) {
        sharedService = [[JVITwitterService alloc] init];
    }

    return sharedService;
}

- (void)getHomeTimelineWithSuccess:(void (^)(NSArray *))success failed:(void (^)(NSError *))failure {
    [_manager GET:@"statuses/home_timeline.json" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *responseArray = responseObject;
        NSMutableArray *list = [[NSMutableArray alloc] init];
        for (id item in responseArray) {
            [list addObject:[[JVITweet alloc] initWithDictionary:item]];
        }

        if (success) {
            success(list);
        }
    }     failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}


@end