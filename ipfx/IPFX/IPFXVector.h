//
//  Vector.h
//  ipfx
//
//  Created by valentinkovalski on 12/16/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IPFXVector : NSObject
@property (assign) CGFloat x;
@property (assign) CGFloat y;

- (instancetype)initWithX:(CGFloat)x andY:(CGFloat)y;

- (IPFXVector*)add:(IPFXVector *)v;
- (IPFXVector*)sub:(IPFXVector *)v;
- (IPFXVector*)mul:(IPFXVector *)v;
- (IPFXVector*)add:(IPFXVector *)v C:(CGFloat)C;
- (IPFXVector*)mull:(IPFXVector *)v C:(CGFloat)C;
- (IPFXVector*)center:(IPFXVector *)v;
- (IPFXVector*)slide:(IPFXVector *)v i:(CGFloat)i;

- (CGFloat)mod;
- (CGFloat)k;
- (CGFloat)kd;

@end
