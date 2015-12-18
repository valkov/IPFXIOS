//
//  IPFXCurve.m
//  ipfx
//
//  Created by valentinkovalski on 12/18/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import "IPFXCurve.h"
#import "IPFXVector.h"

@interface IPFXCurve ()
@property (retain) IPFXVector *p1;
@property (retain) IPFXVector *p2;

@property (assign) CGFloat dx;
@property (assign) CGFloat m1;
@property (assign) CGFloat m2;
@property (assign) CGFloat k1;
@property (assign) CGFloat k2;
@property (assign) CGFloat d1;
@property (assign) CGFloat d2;
@end

@implementation IPFXCurve

- (instancetype)initWithVector:(IPFXVector*)p1 p2:(IPFXVector*)p2 v1:(IPFXVector*)v1 v2:(IPFXVector*)v2 {
    if(self = [super init]) {
        [self compileP1:p1 p2:p2 v1:v1 v2:v2];
    }
    return self;
}

- (void)compileP1:(IPFXVector *)p1 p2:(IPFXVector *)p2 v1:(IPFXVector *)v1 v2:(IPFXVector *)v2 {
    self.p1 = p1;
    self.p2 = p2;
    self.dx = self.p2.x - self.p1.x;
    self.m1 = [v1 mod];
    self.m2 = [v2 mod];
    self.k1 = [v1 k];
    self.k2 = [v2 k];
    self.d1 = [v1 kd];
    self.d2 = [v2 kd];
}

- (CGFloat)calc:(CGFloat)x {
    if (self.dx == 0) {
        return self.p1.y;
    }
    
    CGFloat i = x;
    CGFloat o = 1 - i;
    
    CGFloat yv1 = self.k1 * i;
    CGFloat yv2 = -self.k2 * o;
    
    CGFloat f1 = self.m1 * o / (1 + self.d1 * i);
    CGFloat f2 = self.m2 * i / (1 + self.d2 * o);
    
    CGFloat F = f1 + f2 + 1;
    CGFloat pc1 = f1 / F;
    CGFloat pc2 = f2 / F;
    
    CGFloat y1 = self.p1.y + yv1;
    CGFloat y2 = self.p2.y + yv2;
    CGFloat y3 = self.p1.y * o + self.p2.y * i;
    
    return y1 * pc1 + y2 * pc2 + y3 / F;
}

@end
