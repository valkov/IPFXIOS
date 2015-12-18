//
//  AppDelegate.m
//  ipfx
//
//  Created by valentinkovalski on 12/16/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import "AppDelegate.h"
#import "IPFXInterpolator.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    IPFXInterpolator *interpolator = [IPFXInterpolator parseUrl:@"http://www.ipfx.org/?p=7ffffffe575efffe9e02fffed8f6fffe&l=2f13c5ac138b3d6ad338a5a77a8386807d6e"];
   
    for (NSUInteger i = 0; i <= 100; i++) {
        CGFloat x = (CGFloat)i / 100.0f;
        NSLog(@"x: %0.4f | f(x): %0.4f", x, [interpolator calc:x]);
    }
    
    return YES;
}

@end
