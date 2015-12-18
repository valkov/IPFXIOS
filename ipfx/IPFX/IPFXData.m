//
//  IPFXData.m
//  ipfx
//
//  Created by valentinkovalski on 12/18/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import "IPFXData.h"
#import "IPFXVector.h"
#import "IPFXFunction.h"

@implementation IPFXDataLine
- (instancetype)initWithV1:(IPFXVector*)v1 v2:(IPFXVector*)v2 f:(CGFloat)f {
    if(self = [super init]) {
        self.v1 = v1;
        self.v2 = v2;
        self.f = f;
    }
    return self;
}
@end

@implementation IPFXCaret
- (instancetype)initWithData:(NSString*)data pos:(NSInteger)pos {
    if(self = [super init]) {
        self.data = data;
        self.pos = pos;
    }
    return self;
}
@end


@implementation IPFXData

- (instancetype)initWithPoints:(NSArray*)points andLines:(NSArray*)lines {
    if(self = [super init]) {
        _points = [points mutableCopy];
        _lines = [lines mutableCopy];
    }
    
    return self;
}

+ (NSDictionary*)urlParams:(NSString*)url {
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    NSArray *urlComponents = [url componentsSeparatedByString:@"&"];
    
    for (NSString *keyValuePair in urlComponents)
    {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
        if([key rangeOfString:@"?"].location != NSNotFound) {
            NSArray *keyParts = [key componentsSeparatedByString:@"?"];
            if(keyParts.count == 2)
                key = keyParts[1];
        }
        NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
        
        [queryStringDictionary setObject:value forKey:key];
    }
    return queryStringDictionary;
}

+ (instancetype)parseUrl:(NSString*)url {
    
    NSDictionary *urlParams = [self urlParams:url];
    NSString *pdata = urlParams[@"p"];
    NSString *ldata = urlParams[@"l"];
    
    if(!pdata.length || !ldata.length)
        return [self createBase];
    
    if ([self checkDataPData:pdata lData:ldata]) {
        NSArray *points = [self pointsFromData:pdata];
        NSArray *lines = [self linesFromData:ldata andPoints:points];
        return [[IPFXData alloc] initWithPoints:points andLines:lines];
    }
    
    return nil;
}

+ (instancetype)createBase {
    NSMutableArray *points = [NSMutableArray new];
    NSMutableArray *lines = [NSMutableArray new];
   
    [points addObject:[[IPFXVector alloc] initWithX:0.0f andY:0.0f]];
    [points addObject:[[IPFXVector alloc] initWithX:1.0f andY:0.0f]];

    [lines addObject:[[IPFXDataLine alloc] initWithV1:[[IPFXVector alloc] initWithX:0.33f andY:0.0f] v2:[[IPFXVector alloc] initWithX:-0.33f andY:0.0f] f:IPFXFunctionTypeCurve]];
    
    return [[IPFXData alloc] initWithPoints:points andLines:lines];
}

+ (BOOL)checkDataPData:(NSString*)pdata lData:(NSString*)ldata {
    if([self checkDataAlphabet:pdata] && [self checkDataAlphabet:ldata]){
        
        if(pdata.length % 8 != 0){
            return NO;
        }
        
        int pc = (int)floorf(pdata.length / 8) + 1;
        
        IPFXCaret *caret = [[IPFXCaret alloc] initWithData:ldata pos:0];
        
        NSInteger i = 0;
        while (i < pc - 1) {
            
            NSInteger f = [self readHexValue:caret size:1];
            
            switch (f) {
                case IPFXFunctionTypeCurve :
                    caret.pos = caret.pos + 16;
                    break;
                case IPFXFunctionTypeCurveLL :
                    caret.pos = caret.pos + 8;
                    break;
                case IPFXFunctionTypeCurveLR :
                    caret.pos = caret.pos + 8;
                    break;
                case IPFXFunctionTypeCurveT :
                    caret.pos = caret.pos + 8;
                    break;
                case IPFXFunctionTypeLinear :
                    //caret.pos = caret.pos + 0;
                    break;
                case IPFXFunctionTypeHalfSine :
                    caret.pos = caret.pos + 8;
                    break;
                case IPFXFunctionTypeConstant :
                    //caret.pos = caret.pos + 0;
                    break;
                    
                default :
                    return false;
                    
            }
            
            if(caret.pos > ldata.length){
                return NO;
            }
            
            i++;
        }
        
        return caret.pos == ldata.length;
        
    }
    
    return NO;
}

+ (BOOL)checkDataAlphabet:(NSString*)data {
    for(int i = 0; i < data.length; i++){
        if(![self inAlphabet:[data characterAtIndex:i]]) {
            return NO;
        }
    }
    return YES;
}


+ (NSArray*)pointsFromData:(NSString*)data {
    NSMutableArray *points = [NSMutableArray new];
    IPFXCaret *caret = [[IPFXCaret alloc] initWithData:data pos:0];
    
    IPFXVector *p0 = [[IPFXVector alloc] initWithX:0.0f andY:[self fromGridY:[self readHexValue:caret size:4]]];
    IPFXVector *p2 = [[IPFXVector alloc] initWithX:1.0f andY:[self fromGridY:[self readHexValue:caret size:4]]];
    
    [points addObject:p0];
    
    while(caret.pos < data.length){
        [points addObject:[[IPFXVector alloc] initWithX:[self fromGridX:[self readHexValue:caret size:4]] andY:[self fromGridY:[self readHexValue:caret size:4]]]];
    }
    
    [points addObject:p2];
    
    return points;
}

+ (NSArray*)linesFromData:(NSString*)data andPoints:(NSArray*)points {
    NSMutableArray *lines = [NSMutableArray new];
    IPFXCaret *caret = [[IPFXCaret alloc] initWithData:data pos:0];
    
    int i = 0;
    
    while (caret.pos < data.length) {
        
        NSInteger f = [self readHexValue:caret size:1];
        IPFXVector *v1;
        IPFXVector *v2;
        
        switch (f) {
            case IPFXFunctionTypeCurve : {
                v1 = [[IPFXVector alloc] initWithX:[self fromGridVX:[self readHexValue:caret size:4]] andY:[self fromGridVY:[self readHexValue:caret size:4]]];
                v2 = [[IPFXVector alloc] initWithX:[self fromGridVX:[self readHexValue:caret size:4]] andY:[self fromGridVY:[self readHexValue:caret size:4]]];
                break;
            }
            case IPFXFunctionTypeCurveLL : {
                v1 = [[IPFXVector alloc] initWithX:0 andY:0];
                v2 = [[IPFXVector alloc] initWithX:[self fromGridVX:[self readHexValue:caret size:4]] andY:[self fromGridVY:[self readHexValue:caret size:4]]];
                break;
            }
            case IPFXFunctionTypeCurveLR : {
                v1 = [[IPFXVector alloc] initWithX:[self fromGridVX:[self readHexValue:caret size:4]] andY:[self fromGridVY:[self readHexValue:caret size:4]]];
                v2 = [[IPFXVector alloc] initWithX:0 andY:0];
                break;
            }
            case IPFXFunctionTypeCurveT : {
                IPFXVector *p1 = points[i];
                IPFXVector *p2 = points[i+1];
                v1 = [[IPFXVector alloc] initWithX:[self fromGridVX:[self readHexValue:caret size:4]] andY:[self fromGridVY:[self readHexValue:caret size:4]]];
                v2 = [[p1 add:v1] sub:p2];
                break;
            }
            case IPFXFunctionTypeLinear: {
                break;
            }
            case IPFXFunctionTypeHalfSine : {
                v1 = [[IPFXVector alloc] initWithX:[self fromGridVX:[self readHexValue:caret size:4]] andY:[self fromGridVY:[self readHexValue:caret size:4]]];
                break;
            }
            case IPFXFunctionTypeConstant : {
                break;
            }
        }
        
        [lines addObject:[[IPFXDataLine alloc] initWithV1:v1 v2:v2 f:f]];
        
        i++;
        
    }
    
    return lines;
}

+ (CGFloat)fromGridX:(NSInteger)x {
    return (CGFloat)x / GRID_X;
}

+ (CGFloat)fromGridY:(NSInteger)y {
    return ((CGFloat)y - GRID_Y0) / GRID_Y;
}

+ (CGFloat)fromGridVX:(NSInteger)vx {
    return ((CGFloat)vx - GRID_Y0) / GRID_VX;
}

+ (CGFloat)fromGridVY:(NSInteger)vy {
    return ((CGFloat)vy - GRID_Y0) / GRID_VY;
}

+ (BOOL)inAlphabet:(char)c {
    return (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f');
}

+ (unsigned)readHexValue:(IPFXCaret *)caret size:(NSInteger)size {
    
    NSString *vs;
    
    NSRange range = NSMakeRange(caret.pos, size);
    if(range.location + range.length <= caret.data.length)
        vs = [caret.data substringWithRange:range];
    
    caret.pos = caret.pos + size;
    
    if(vs != nil){
        unsigned result = 0;
        NSScanner *scanner = [NSScanner scannerWithString:vs];
        [scanner scanHexInt:&result];
        return result;
    } else {
        return -1;
    }
    
}
@end
