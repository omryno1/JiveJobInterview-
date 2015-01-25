//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JVIImage;


@interface JVIFeedTableViewCell : UITableViewCell

- (void)updateData:(JVIImage *)image;

+ (CGFloat)heightForWidth:(CGFloat)width;

@end