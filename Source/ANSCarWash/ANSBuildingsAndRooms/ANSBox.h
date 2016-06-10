//
//  ANSRoom.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSRoom.h"
#import "ANSCarWasher.h"
#import "ANSCar.h"

@interface ANSBox : ANSRoom
@property (nonatomic, readonly)                      NSArray *carsQueue;
@property (nonatomic, readonly, getter = isOccupied) BOOL    occupied;

- (void)addCar:(ANSCar *)car;
- (void)removeCar:(ANSCar *)car;

- (ANSCarWasher *)randomWasher;
- (BOOL)isReadyToUse;

@end
