//
//  ANSCar.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANSMoneyOwner.h"

typedef enum {
    ANSCarDirty,
    ANSCarClean
} ANSCarStatus;

@interface ANSCar : NSObject <ANSMoneyOwner>
@property (nonatomic, assign) ANSCarStatus status;

@end
