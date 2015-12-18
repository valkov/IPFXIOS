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
    
    IPFXInterpolator *interpolator = [IPFXInterpolator parseUrl:@"http://www.ipfx.org/?p=7ffffffe&l=3cff0829f"];
   
    for (NSUInteger i = 0; i <= 10; i++) {
        CGFloat x = (CGFloat)i / 10.0f;
        NSLog(@"x: %0.1f | f(x): %0.4f", x, [interpolator calc:x]);
    }
    
    return YES;
}

@end
