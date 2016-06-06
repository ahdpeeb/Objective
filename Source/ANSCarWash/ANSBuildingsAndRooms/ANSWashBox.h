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
@property (nonatomic, readonly) NSArray *carsLine;
@property (nonatomic, readonly) NSArray *carWashers;

- (void)addCarToRoom:(ANSCar *) car;
- (void)removeCarFromRoom:(ANSCar *) car;
- (void)removeCarFromRoomAtIndex:(NSUInteger) index;
- (void)addCarWasherToRoom:(ANSCarWasher *) washer;
- (void)removeCarWasherFromRoom:(ANSCarWasher *) washer;

@end
