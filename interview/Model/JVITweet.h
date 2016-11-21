//
// Created by ShaLi Shaltiel on 03/02/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@class JVIUser;

@interface JVITweet : JSONModel

@property (strong, nonatomic) JVIUser *user;
@property (strong, nonatomic) NSString *text;

@end
