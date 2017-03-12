//
// Created by ShaLi Shaltiel on 03/02/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

#import "JVIUser.h"
#import "JVIMedia.h"

@class JVIUser;
@class JVIEntities;

@interface JVITweet : JSONModel

@property (strong, nonatomic) JVIEntities *entities;
@property (strong, nonatomic) JVIUser *user;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;

@end
