//
//  IPFXInterpolator.h
//  ipfx
//
//  Created by valentinkovalski on 12/18/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPFXFunction.h"

@interface IPFXInterpolator : NSObject
/**
 * parse URL to get encoded points and lines data
 * it can be passed with or without host
 * it should start with '?' char
 * ex.
 * http://ipfx.org/?p=7ffffffe&l=09c287fff63d67fff
 * or
 * ?p=7ffffffe&l=09c287fff63d67fff
 * both will work
 *
 * @param url - data encoded in the url
 * @return
 */
+ (instancetype)parseUrl:(NSString*)url;

/**
 * calculate Interpolator function
 * @param x -
 * @return - F(x) if x belongs to [0, 1], 0 otherwise
 */
- (CGFloat)calc:(CGFloat)x;
@end

