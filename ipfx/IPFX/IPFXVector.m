//
//  Vector.m
//  ipfx
//
//  Created by valentinkovalski on 12/16/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import "IPFXVector.h"

@implementation IPFXVector

- (instancetype)initWithX:(CGFloat)x andY:(CGFloat)y {
    if(self = [super init]) {
        _x = x;
        _y = y;
    }
    return  self;
}

- (IPFXVector*)add:(IPFXVector *)v {
    return [[IPFXVector alloc] initWithX:self.x + v.x andY:self.y + v.y];
}

- (IPFXVector*)sub:(IPFXVector *)v {
    return [[IPFXVector alloc] initWithX:self.x - v.x andY:self.y - v.y];
}

- (IPFXVector*)mul:(IPFXVector *)v {
    return [[IPFXVector alloc] initWithX:self.x * v.x andY:self.y * v.y];
}

- (IPFXVector*)add:(IPFXVector *)v C:(CGFloat)C {
    return [[IPFXVector alloc] initWithX:self.x + C andY:self.y + C];
}

- (IPFXVector*)mull:(IPFXVector *)v C:(CGFloat)C {
    return [[IPFXVector alloc] initWithX:self.x * C andY:self.y * C];
}

- (IPFXVector*)center:(IPFXVector *)v {
    return [[IPFXVector alloc] initWithX:(self.x + v.x) / 2 andY:(self.y + v.y) / 2];
}

- (IPFXVector*)slide:(IPFXVector *)v i:(CGFloat)i {
    CGFloat o = 1 - i;
    return [[IPFXVector alloc] initWithX:self.x * o + v.x * i andY:self.y * o + v.y * i];
}

- (CGFloat)mod {
    return sqrtf(self.x * self.x + self.y * self.y);
}

- (CGFloat)k {
    if (self.x != 0) {
        return self.y / self.x;
    } else {
        return 0;
    }
}

- (CGFloat)kd {
    if (self.x != 0) {
        CGFloat vk = self.y / self.x;
        return sqrtf(1 + vk * vk);
    } else {
        return 0;
    }
}

@end
