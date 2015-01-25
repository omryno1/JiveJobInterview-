//
// Created by ShaLi Shaltiel on 27/08/14.
// Copyright (c) 2014 Jive Software. All rights reserved.
//

#import "UIView+JVIView.h"


@implementation UIView (JVIView)

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom {
    CGRect rect = self.frame;
    rect.origin.y = CGRectGetHeight(self.superview.bounds) - bottom - CGRectGetHeight(rect);
    self.frame = rect;
}

- (void)setRightRelativeToParent:(CGFloat)right {
    CGRect rect = self.frame;
    rect.origin.x = CGRectGetWidth(self.superview.bounds) - right - CGRectGetWidth(rect);
    self.frame = rect;
}

- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (void)setTop:(CGFloat)top {
    CGRect rect = self.frame;
    rect.origin.y = top;
    self.frame = rect;
}

- (void)setLeft:(CGFloat)left {
    CGRect rect = self.frame;
    rect.origin.x = left;
    self.frame = rect;

}

- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;

}

- (void)setOrigin:(CGPoint)origin {
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;

}

@end