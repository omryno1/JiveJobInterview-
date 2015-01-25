//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface JVIEntity : JSONModel

@property (nonatomic) NSString *id;

+(instancetype) entityFromDictionary: (NSDictionary *) dictionary;

@end