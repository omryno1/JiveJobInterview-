//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface JVIUser : JSONModel

@property (nonatomic) NSString *full_name;
@property (nonatomic) NSURL *profile_picture;

@end