//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVIFeedTableViewCell.h"
#import "UIView+JVIView.h"
#import "UIImageView+WebCache.h"
#import "JVITweet.h"
#import "JVIUser.h"

@implementation JVIFeedTableViewCell {
    UIImageView *_avatarImage;
    UILabel *_nameLabel;
    UILabel *_textLabel;
}

const CGFloat kGutter = 15;
const CGFloat kMargin = 10;
const CGFloat kAvatarSize = 40;
static UIFont *nameFont;
static UIFont *textFont;

+ (void)initialize {
    nameFont = [UIFont systemFontOfSize:14.0f];
    textFont = [UIFont systemFontOfSize:16.0f];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatarImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_avatarImage];

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = nameFont;
        [self.contentView addSubview:_nameLabel];

        _textLabel = [[UILabel alloc] init];
        _textLabel.font = textFont;
        _textLabel.numberOfLines = 0;
        [self.contentView addSubview:_textLabel];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.height = [JVIFeedTableViewCell heightForWidth:self.width Text:_textLabel.text];

    _avatarImage.frame = CGRectMake(kGutter, kGutter, kAvatarSize, kAvatarSize);

    _nameLabel.left = _avatarImage.right + kMargin;
    _nameLabel.top = kGutter;
    _nameLabel.height = nameFont.lineHeight;
    _nameLabel.width = self.width - _avatarImage.right - kMargin - kGutter;

    _textLabel.left = kGutter;
    _textLabel.top = MAX(_avatarImage.bottom, _nameLabel.bottom) + kMargin;
    _textLabel.width = self.width - kGutter * 2;
    _textLabel.height = self.height - _textLabel.top - kMargin;
}

- (void)updateData:(JVITweet *)tweet {
    _nameLabel.text = tweet.user.name;
    [_avatarImage sd_setImageWithURL:tweet.user.profile_image_url];
    _textLabel.text = tweet.text;
}

+ (CGFloat)heightForWidth:(CGFloat)width Text:(NSString *)tweetText {
    CGRect textSize = [tweetText boundingRectWithSize:CGSizeMake(width - kGutter * 2, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : textFont} context:nil];
    return kGutter + MAX(kAvatarSize, nameFont.lineHeight) + kMargin + textSize.size.height + kMargin;
}
@end