//
//  IPFXHalfSine.m
//  ipfx
//
//  Created by valentinkovalski on 12/18/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import "IPFXHalfSine.h"

@interface IPFXHalfSine ()
@property (retain) IPFXVector *p1;
@property (retain) IPFXVector *p2;

@property (assign) CGFloat dx;
@property (assign) CGFloat dx1;
@property (assign) CGFloat k1;
@property (assign) CGFloat k2;
@property (assign) CGFloat step1;
@property (assign) CGFloat step2;
@end

@implementation IPFXHalfSine

- (instancetype)initWithVector:(IPFXVector*)p1 p2:(IPFXVector*)p2 v1:(IPFXVector*)v1 {
    if(self = [super init]) {
        [self compileP1:p1 p2:p2 v1:v1 v2:nil];
    }
    return self;
}

- (void)compileP1:(IPFXVector *)p1 p2:(IPFXVector *)p2 v1:(IPFXVector *)v1 v2:(IPFXVector *)v2 {
    self.p1 = p1;
    self.p2 = p2;
    self.dx = self.p2.x - self.p1.x;
    
    if (self.dx > 0) {
        
        self.dx1 = v1.x / self.dx;
        CGFloat dx2 = 1 - self.dx1;
        
        self.step1 = 0.5f * M_PI / self.dx1;
        self.step2 = 0.5f * M_PI / dx2;
        
        self.k1 = v1.y;
        self.k2 = self.p1.y + v1.y - self.p2.y;
        
    }
}

- (CGFloat)calc:(CGFloat)x {
    if (self.dx == 0) {
        return self.p1.y;
    }
    
    if (x < self.dx1) {
        return self.p1.y + self.k1 * sinf(x * self.step1);
    } else {
        return self.p2.y + self.k2 * sinf((x - self.dx1) * self.step2 + 0.5 * M_PI);
    }
}

@end
