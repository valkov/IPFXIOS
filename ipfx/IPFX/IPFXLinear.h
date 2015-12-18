//
//  IPFXLinear.h
//  ipfx
//
//  Created by valentinkovalski on 12/18/15.
//  Copyright © 2015 valentinkovalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPFXFunction.h"
#import "IPFXVector.h"

@interface IPFXLinear : NSObject<IPFXFunction>
- (instancetype)initWithVector:(IPFXVector*)p1 p2:(IPFXVector*)p2;
@end
