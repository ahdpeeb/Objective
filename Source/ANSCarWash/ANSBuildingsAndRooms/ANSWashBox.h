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

- (void)addCarToRoom:(ANSCar *) car;
- (void)removeCarFromRoom:(ANSCar *) car;

- (void)addCarWasherToRoom:(ANSCarWasher *) washer;
- (void)removeCarWasherFromRoom:(ANSCarWasher *) washer;
- (ANSCarWasher *)getRandomWasher;


@end
