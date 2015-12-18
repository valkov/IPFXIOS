//
//  IPFXConstant.h
//  ipfx
//
//  Created by valentinkovalski on 12/16/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPFXFunction.h"
#import "IPFXVector.h"

@interface IPFXConstant : NSObject<IPFXFunction>

- (instancetype)initWithVector:(IPFXVector*)p1;

@end
