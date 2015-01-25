//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVIFeedTableViewCell.h"
#import "UIView+JVDView.h"
#import "JVIImage.h"
#import "UIImageView+WebCache.h"
#import "JVIUser.h"

@implementation JVIFeedTableViewCell {
    UIImageView *_avatarImage;
    UILabel *_nameLabel;
    UIImageView *_image;
}

const CGFloat kGutter = 15;
const CGFloat kMargin = 10;
const CGFloat kAvatarSize = 40;
static UIFont *nameFont;

+ (void)initialize {
    nameFont = [UIFont systemFontOfSize:14.0f];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatarImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_avatarImage];

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = nameFont;
        [self.contentView addSubview:_nameLabel];

        _image = [[UIImageView alloc] init];
        [self.contentView addSubview:_image];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _avatarImage.frame = CGRectMake(kGutter, kGutter, kAvatarSize, kAvatarSize);

    _nameLabel.left = _avatarImage.right + kMargin;
    _nameLabel.top = kGutter;
    _nameLabel.height = nameFont.lineHeight;
    _nameLabel.width = self.width - _avatarImage.right - kMargin*2;

    _image.left = 0;
    _image.top = MAX(_avatarImage.bottom, _nameLabel.bottom) + kGutter;
    _image.width = self.width;
    _image.height = self.width;
}

- (void)updateImage:(JVIImage *)image {
    _nameLabel.text = image.user.full_name;
    [_avatarImage sd_setImageWithURL:[[NSURL alloc] initWithString:image.user.profile_picture]];
    [_image sd_setImageWithURL:[[NSURL alloc] initWithString:image.imageUrl]];
}

+ (CGFloat)heightForWidth:(CGFloat)width {
    return kGutter + MAX(kAvatarSize, nameFont.lineHeight) + kGutter + width + kGutter;
}
@end