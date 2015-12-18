//
//  IPFXInterpolator.h
//  ipfx
//
//  Created by valentinkovalski on 12/18/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPFXFunction.h"

@interface IPFXLine : NSObject
@property (retain) NSObject<IPFXFunction> *func;
@property (assign) CGFloat step;

- (instancetype)initWithFunction:(NSObject<IPFXFunction>*)func andStep:(CGFloat)step;
+ (instancetype)createWithP1:(IPFXVector*)p1 p2:(IPFXVector*)p2 v1:(IPFXVector*)v1 v2:(IPFXVector*)v2 f:(IPFXFunctionType)f;
@end

@interface IPFXInterpolator : NSObject
- (instancetype)initWithPoints:(NSArray*)points andLines:(NSArray*)lines;
+ (instancetype)parseUrl:(NSString*)url;
- (CGFloat)calc:(CGFloat)x;
@end

