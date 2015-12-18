//
//  IPFXData.h
//  ipfx
//
//  Created by valentinkovalski on 12/18/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPFXVector.h"

#define GRID_X 65535.0f
#define GRID_Y 32767.0f
#define GRID_Y0 32767.0f
#define GRID_VX 21844.0
#define GRID_VY 10922.0f

@interface IPFXData : NSObject
@property (readonly) NSMutableArray *points;
@property (readonly) NSMutableArray *lines;

- (instancetype)initWithPoints:(NSArray*)points andLines:(NSArray*)lines;
+ (instancetype)parseUrl:(NSString*)url;
@end

@interface IPFXDataLine : NSObject
@property (retain) IPFXVector *v1;
@property (retain) IPFXVector *v2;
@property (assign) CGFloat f;

- (instancetype)initWithV1:(IPFXVector*)v1 v2:(IPFXVector*)v2 f:(CGFloat)f;
@end

@interface IPFXCaret : NSObject
@property (copy) NSString *data;
@property (assign) NSInteger pos;

- (instancetype)initWithData:(NSString*)data pos:(NSInteger)pos;
@end

