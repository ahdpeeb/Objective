//
//  ANSRoom.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSCarWasher.h"
#import "ANSAccountant.h"
#import "ANSDirector.h"

@interface ANSRoom : NSObject

@property (nonatomic, readonly) NSArray *carsLine;
@property (nonatomic, retain) NSArray *carWashers;
@property (nonatomic, retain) ANSAccountant *accountant;
@property (nonatomic, retain) ANSAccountant *direcrot;

- (void)addCarToRoom:(ANSCar *) car;
- (void)removeCarFromRoom:(ANSCar *) car;
- (void)removeCarFromRoomAtIndex:(NSUInteger) index;

@end
