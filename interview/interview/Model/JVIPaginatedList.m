//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVIPaginatedList.h"
#import "JVIImage.h"


@implementation JVIPaginatedList {

}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err {
    self = [super initWithDictionary:dict error:err];
    if (self) {
        NSDictionary *data = dict[@"data"];
        NSMutableArray *parsedData = [[NSMutableArray alloc] initWithCapacity:data.count];
        NSUInteger i = 0;
        for (NSDictionary *item in data) {
            JVIImage *image = [[JVIImage new] initWithDictionary:item error:nil];
            if (image) {
                parsedData[i++] = image;
            }
        }

        self.entities = parsedData;
    }

    return self;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end