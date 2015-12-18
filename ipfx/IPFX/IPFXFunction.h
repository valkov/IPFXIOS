//
//  IPFXFunction.h
//  ipfx
//
//  Created by valentinkovalski on 12/16/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPFXVector.h"

typedef NS_ENUM(NSInteger, IPFXFunctionType) {
    IPFXFunctionTypeCurve,
    IPFXFunctionTypeCurveLL,
    IPFXFunctionTypeCurveLR,
    IPFXFunctionTypeCurveT,
    IPFXFunctionTypeLinear,
    IPFXFunctionTypeHalfSine,
    IPFXFunctionTypeConstant
};

@protocol IPFXFunction <NSObject>
- (void)compileP1:(IPFXVector *)p1 p2:(IPFXVector *)p2 v1:(IPFXVector *)v1 v2:(IPFXVector *)v2;
- (CGFloat)calc:(CGFloat)x;
@end
