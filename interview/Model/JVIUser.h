//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface JVIUser : JSONModel

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *profile_background_image_url_https;


@end
