//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVIInstagramService.h"
#import "AFHTTPSessionManager.h"


@implementation JVIInstagramService {

    AFHTTPSessionManager *_manager;
    NSString *_accessToken;
}

static JVIInstagramService *sharedService;

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    NSURL *baseUrl = [[NSURL alloc] initWithString:@"https://api.instagram.com/v1"];
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];

    _accessToken = @"1670815861.1fb234f.b9690c21d125435a8f722856f8043ea2"; // Hard coded.

    return self;
}

+ (instancetype)sharedService {
    if (!sharedService) {
        sharedService = [[JVIInstagramService alloc] init];
    }
    
    return sharedService;
}

@end