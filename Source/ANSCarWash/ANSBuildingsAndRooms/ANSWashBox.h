//
//  ANSRoom.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSAdminRoom.h"
#import "ANSCarWasher.h"
#import "ANSCar.h"

@interface ANSWashBox : ANSAdminRoom
@property (nonatomic, readonly)                               NSArray *carsQueue;
@property (nonatomic, readonly, getter = isFullWithCars)      BOOL    fullWithCars;

- (void)addCar:(ANSCar *)car;
- (void)removeCar:(ANSCar *)car;

- (ANSCarWasher *)randomWasher;
- (BOOL)isReady;

@end
