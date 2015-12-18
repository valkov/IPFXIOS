//
//  IPFXConstant.m
//  ipfx
//
//  Created by valentinkovalski on 12/16/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import "IPFXConstant.h"

@interface IPFXConstant ()
@property (assign) CGFloat v;
@end

@implementation IPFXConstant
- (instancetype)initWithVector:(IPFXVector*)p1 {
    if(self = [super init]) {
        [self compileP1:p1 p2:nil v1:nil v2:nil];
    }
    return self;
}


- (void)compileP1:(IPFXVector *)p1 p2:(IPFXVector *)p2 v1:(IPFXVector *)v1 v2:(IPFXVector *)v2 {
    self.v = p1.y;
}

- (CGFloat)calc:(CGFloat)x {
    return self.v;
}

@end
