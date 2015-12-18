//
//  IPFXInterpolator.m
//  ipfx
//
//  Created by valentinkovalski on 12/18/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import "IPFXInterpolator.h"
#import "IPFXVector.h"
#import "IPFXCurve.h"
#import "IPFXLinear.h"
#import "IPFXHalfSine.h"
#import "IPFXConstant.h"
#import "IPFXData.h"

@interface IPFXLine : NSObject
@property (retain) NSObject<IPFXFunction> *func;
@property (assign) CGFloat step;

- (instancetype)initWithFunction:(NSObject<IPFXFunction>*)func andStep:(CGFloat)step;
+ (instancetype)createWithP1:(IPFXVector*)p1 p2:(IPFXVector*)p2 v1:(IPFXVector*)v1 v2:(IPFXVector*)v2 f:(IPFXFunctionType)f;
@end

@implementation IPFXLine
- (instancetype)initWithFunction:(NSObject<IPFXFunction>*)func andStep:(CGFloat)step {
    if(self = [super init]) {
        _func = func;
        _step = step;
    }
    
    return self;
}

+ (instancetype)createWithP1:(IPFXVector*)p1 p2:(IPFXVector*)p2 v1:(IPFXVector*)v1 v2:(IPFXVector*)v2 f:(IPFXFunctionType)f {
    NSObject<IPFXFunction> *func;
    
    switch (f) {
        case IPFXFunctionTypeCurve: {
            func = [[IPFXCurve alloc] initWithVector:p1 p2:p2 v1:v1 v2:v2];
            break;
        }
        case IPFXFunctionTypeCurveLL: {
            v1 = [[IPFXVector alloc] initWithX:0 andY:0];
            func = [[IPFXCurve alloc] initWithVector:p1 p2:p2 v1:v1 v2:v2];
            break;
        }
        case IPFXFunctionTypeCurveLR: {
            v2 = [[IPFXVector alloc] initWithX:0 andY:0];
            func = [[IPFXCurve alloc] initWithVector:p1 p2:p2 v1:v1 v2:v2];
            break;
        }
        case IPFXFunctionTypeCurveT: {
            v2 = [[p1 add:v1] sub:p2];
            func = [[IPFXCurve alloc] initWithVector:p1 p2:p2 v1:v1 v2:v2];
            break;
        }
        case IPFXFunctionTypeLinear: {
            func = [[IPFXLinear alloc]initWithVector:p1 p2:p2];
            break;
        }
        case IPFXFunctionTypeHalfSine: {
            func = [[IPFXHalfSine alloc] initWithVector:p1 p2:p2 v1:v1];
            break;
        }
        case IPFXFunctionTypeConstant: {
            func = [[IPFXConstant alloc] initWithVector:p1];
            break;
        }
        default: {
            return nil;
        }
            
    }
    
    float dx = p2.x - p1.x;
    float step;
    if (dx > 0){
        step = 1 / dx;
    } else {
        step = 0;
    }
    
    return [[IPFXLine alloc] initWithFunction:func andStep:step];
}

- (CGFloat)calc:(CGFloat)x {
    return [self.func calc:x * self.step];
}

@end

@interface IPFXInterpolator ()

@property (retain) NSMutableArray *points;
@property (retain) NSMutableArray *lines;

@end


@implementation IPFXInterpolator

- (instancetype)initWithPoints:(NSArray*)points andLines:(NSArray*)lines {
    if(self = [super init]) {
        _points = [points mutableCopy];
        _lines = [lines mutableCopy];
    }
    
    return self;
}

+ (instancetype)parseUrl:(NSString*)url {
    IPFXData *data = [IPFXData parseUrl:url];
    
    if(data != nil) {
        
        NSMutableArray *points = [[NSMutableArray alloc] initWithArray:data.points];
        
        NSMutableArray *lines = [NSMutableArray new];
        
        int i = 0;
        for (IPFXDataLine *l in data.lines) {
            
            IPFXVector *p1 = points[i];
            IPFXVector *p2 = points[i + 1];
            
            IPFXLine *line = [IPFXLine createWithP1:p1 p2:p2 v1:l.v1 v2:l.v2 f:l.f];
            
            if (line == nil) {
                return nil;
            } else {
                [lines addObject:line];
            }
            
            i++;
        }
        
        return [[IPFXInterpolator alloc] initWithPoints:points andLines:lines];
        
    } else {
        return nil;
    }
    
}

- (CGFloat)calc:(CGFloat)x {
    
    if(x >= 0 && x <= 1){
        for(int i = 0; i < self.points.count - 1; i++){
            IPFXVector *p1 = self.points[i];
            IPFXVector *p2 = self.points[i + 1];
            
            if(x >= p1.x && x <= p2.x){
                return [(IPFXLine*)self.lines[i] calc:x- p1.x];
            }
            
        }
        
    }
    
    return 0;
    
}

@end
