//
// Created by ShaLi Shaltiel on 03/02/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVITweet.h"
#import "JVIUser.h"


@implementation JVITweet {

}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.text = dictionary[@"text"];
        self.user = [[JVIUser alloc] initWithDictionary:dictionary[@"user"] error:nil];
    }

    return self;
}

@end