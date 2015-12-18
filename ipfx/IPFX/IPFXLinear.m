//
//  IPFXLinear.m
//  ipfx
//
//  Created by valentinkovalski on 12/18/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import "IPFXLinear.h"

@interface IPFXLinear ()
@property (retain) IPFXVector *p1;
@property (retain) IPFXVector *p2;

@property (assign) CGFloat k;
@end

@implementation IPFXLinear

- (instancetype)initWithVector:(IPFXVector*)p1 p2:(IPFXVector*)p2 {
    if(self = [super init]) {
        [self compileP1:p1 p2:p2 v1:nil v2:nil];
    }
    return self;
}

- (void)compileP1:(IPFXVector *)p1 p2:(IPFXVector *)p2 v1:(IPFXVector *)v1 v2:(IPFXVector *)v2 {
    self.p1 = p1;
    self.p2 = p2;
    CGFloat dx = self.p2.x - self.p1.x;
    if (dx > 0) {
        self.k = [p2 sub:p1].k * dx;
    }
}

- (CGFloat)calc:(CGFloat)x {
    return self.p1.y + self.k * x;}


@end

