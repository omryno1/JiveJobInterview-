//
//  JVIEntities.h
//  interview
//
//  Created by Omry Dabush on 12/03/2017.
//  Copyright © 2017 Jive Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

#import "JVIMedia.h"

@interface JVIEntities : JSONModel

@property (strong, nonatomic) NSArray<JVIMedia, Optional> *media;


@end
