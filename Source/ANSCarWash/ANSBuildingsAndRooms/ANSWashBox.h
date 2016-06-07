//
//  ANSRoom.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSCarWasher.h"
#import "ANSCar.h"

@interface ANSWashBox : NSObject
@property (nonatomic, readonly)         NSArray *carsLine;
@property (nonatomic, readonly)         NSArray *carWashers;
@property (nonatomic, assign, readonly) BOOL    isFullWithCarWasher;
@property (nonatomic, assign, readonly) BOOL    isFullWithCars;

+ (ANSWashBox *)create;

- (void)addCar:(ANSCar *)car;
- (void)removeCar:(ANSCar *)car;

- (void)addCarWasher:(ANSCarWasher *)washer;
- (void)removeCarWasher:(ANSCarWasher *)washer;
- (ANSCarWasher *)randomWasher;

@end
