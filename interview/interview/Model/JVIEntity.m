//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVIEntity.h"
#import "JVIImage.h"


@implementation JVIEntity {

}
+ (instancetype)entityFromDictionary:(NSDictionary *)dictionary {
    NSString *type = dictionary[@"type"];

    JVIEntity *entity = nil;
    if ([type isEqualToString:@"image"]) {
        entity = [[JVIImage alloc] initWithDictionary:dictionary error:nil];
    }

    return entity;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end