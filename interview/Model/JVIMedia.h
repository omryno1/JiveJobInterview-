//
//  JVIMedia.h
//  interview
//
//  Created by Omry Dabush on 12/03/2017.
//  Copyright © 2017 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol JVIMedia
@end

@interface JVIMedia : JSONModel

@property (strong, nonatomic) NSURL *media_url_https;

@end
