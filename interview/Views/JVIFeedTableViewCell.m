//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVIFeedTableViewCell.h"
#import "UIView+JVIView.h"
#import "UIImageView+WebCache.h"
#import "JVITweet.h"
#import "JVIUser.h"

@interface JVIFeedTableViewCell()

@property (strong, nonatomic) UIImageView *avatarImage;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *tweetTextLabel;

@end

@implementation JVIFeedTableViewCell

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
        
        [self.contentView addSubview:self.avatarImage];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.tweetTextLabel];
        
        self.separatorInset = UIEdgeInsetsZero;
        [self setPreservesSuperviewLayoutMargins:NO];
        self.layoutMargins = UIEdgeInsetsZero;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.height = [JVIFeedTableViewCell heightForWidth:self.width Text:self.tweetTextLabel.text];

    self.avatarImage.top = kGutter;
    self.avatarImage.left = kGutter;

    self.nameLabel.left = self.avatarImage.right + kMargin;
    self.nameLabel.top = kGutter;
    self.nameLabel.height = nameFont.lineHeight;
    self.nameLabel.width = self.width - self.avatarImage.right - kMargin - kGutter;

    self.tweetTextLabel.left = kGutter;
    self.tweetTextLabel.top = MAX(self.avatarImage.bottom, self.nameLabel.bottom) + kMargin;
    self.tweetTextLabel.width = self.width - kGutter * 2;
    self.tweetTextLabel.height = self.height - self.tweetTextLabel.top - kMargin;
}

- (void)updateData:(JVITweet *)tweet {
    self.nameLabel.text = tweet.user.name;
    [self.avatarImage sd_setImageWithURL:tweet.user.profile_background_image_url_https completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            NSLog(@"error loading avatar image\n%@", error);
            return;
        }
    }];
    self.tweetTextLabel.text = tweet.text;
}

+ (CGFloat)heightForWidth:(CGFloat)width Text:(NSString *)tweetText {
    CGRect textSize = [tweetText boundingRectWithSize:CGSizeMake(width - kGutter * 2, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : textFont} context:nil];
    return kGutter + MAX(kAvatarSize, nameFont.lineHeight) + kMargin + textSize.size.height + kMargin;
}

+(NSString *)cellIdentifier {
    return @"JVIFeedTableViewCellIdentifier";
}

#pragma mark - Lazy inits

-(UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kAvatarSize, kAvatarSize)];
        _avatarImage.clipsToBounds = YES;
        _avatarImage.layer.cornerRadius = kAvatarSize / 2;
        _avatarImage.layer.borderColor = [UIColor grayColor].CGColor;
        _avatarImage.layer.borderWidth = 0.5;
    }
    return _avatarImage;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = nameFont;
    }
    return _nameLabel;
}

-(UILabel *)tweetTextLabel {
    if (!_tweetTextLabel) {
        _tweetTextLabel = [[UILabel alloc] init];
        _tweetTextLabel.font = textFont;
        _tweetTextLabel.numberOfLines = 0;
    }
    return _tweetTextLabel;
}

@end
