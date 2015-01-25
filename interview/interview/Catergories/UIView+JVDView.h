//
// Created by ShaLi Shaltiel on 27/08/14.
// Copyright (c) 2014 Jive Software. All rights reserved.
//

/**
* Extends the basic UIView with some layouting helper methods
*/
@interface UIView (JVDView)

- (CGFloat)height;

- (CGFloat)width;

- (CGFloat)top;

- (CGFloat)left;

- (CGFloat)right;

- (CGFloat)bottom;

- (void)setBottom:(CGFloat)bottom;

- (void)setRightRelativeToParent:(CGFloat)right;

/**
* Sets the height of the view's frame.
*/
- (void)setHeight:(CGFloat)height;

/**
* Sets the width of the view's frame.
*/
- (void)setWidth:(CGFloat)width;

/**
* Sets the Y position of the view's frame.
*/
- (void)setTop:(CGFloat)top;

/**
* Sets the X position of the view's frame.
*/
- (void)setLeft:(CGFloat)left;

/**
* Sets the size of the view's frame.
*/
- (void)setSize:(CGSize)size;

/**
* Sets the position of the view's frame.
*/
- (void)setOrigin:(CGPoint)origin;
@end