//
//  ANSCar.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANSMoney.h"

typedef enum {
    ANSCarDirty,
    ANSCarClean
} ANSCarStatus;

@interface ANSCar : NSObject <ANSMoney>
@property (nonatomic, assign)           ANSCarStatus    status;
@property (nonatomic, assign, readonly)  float           money;

-(void)acceptMoney:(float)number;
-(void)giveMoney:(float)number;

@end
