//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "JVIEntity.h"

@class JVIUser;


@interface JVIImage : JVIEntity

@property (nonatomic) NSString *imageUrl;
@property (nonatomic) JVIUser *user;

@end