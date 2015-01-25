//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVIImage.h"


@implementation JVIImage {

}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err {
    self = [super initWithDictionary:dict error:err];
    if (self) {
        self.imageUrl = dict[@"images"][@"standard_resolution"][@"url"];
    }

    return self;
}


+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end