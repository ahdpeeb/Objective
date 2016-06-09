//
//  ANSRoom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSWashBox.h"

#import "NSObject+ANSExtension.h"
#import "ANSConstants.h"

@interface ANSWashBox ()
@property (nonatomic, retain) NSMutableArray *mutableCarsQueue;
@property (nonatomic, assign) BOOL           fullWithCars;

- (BOOL)ANS_isWashBoxAvailableForCar:(ANSCar *)car;

@end

@implementation ANSWashBox

@dynamic carsQueue;

#pragma mark -
#pragma mark initialize / deallocate

- (instancetype)init {
    self = [super init];
    self.mutableCarsQueue = [NSMutableArray object];
    self.fullWithCars = NO;
    ANSCarWasher *washer = [ANSCarWasher object];
    [self addWorker:washer];
    
    return self;
}

- (void)dealloc {
    self.mutableCarsQueue = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)carsLine {
    return [[self.mutableCarsQueue copy] autorelease];
}

#pragma mark -
#pragma mark Public methods

- (void)addCar:(ANSCar *)car {
    NSMutableArray *carsLine = self.mutableCarsQueue;
    if ([self ANS_isWashBoxAvailableForCar:car]) {
        [carsLine addObject:car];
    }
    
    if (carsLine.count >= kANSMaxCarCapacity) {
        self.fullWithCars = YES;
    }
}

- (void)removeCar:(ANSCar *)car {
    NSMutableArray *carsLine = self.mutableCarsQueue;
    [carsLine removeObject:car];
    
    if (carsLine.count < kANSMaxCarCapacity) {
        self.fullWithCars = NO;
    }
}

- (ANSCarWasher *)randomWasher {
    NSArray *washers = self.workers;
    NSInteger randomIndex = arc4random_uniform((u_int32_t)(washers.count));
    ANSCarWasher *washer = [washers objectAtIndex:randomIndex];
    
    return washer;
}

- (BOOL)isReady {
    return !self.isFullWithCars; //&& self.carsQueue.count < self.workers.count;
}

#pragma mark -
#pragma mark Privat Methods

- (BOOL)ANS_isWashBoxAvailableForCar:(ANSCar *)car {
    NSMutableArray *carsLine = self.mutableCarsQueue;
    return carsLine.count < kANSMaxCarCapacity && ![carsLine containsObject:car] ;
}

@end
