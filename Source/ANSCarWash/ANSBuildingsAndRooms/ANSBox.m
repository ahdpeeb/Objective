//
//  ANSRoom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSBox.h"

#import "ANSConstants.h"

#import "NSObject+ANSExtension.h"

@interface ANSBox ()
@property (nonatomic, retain) NSMutableArray *mutableCarsQueue;
@property (nonatomic, assign) BOOL           occupied;

- (BOOL)isWashBoxAvailableForCar:(ANSCar *)car;

@end

@implementation ANSBox

@dynamic cars;

#pragma mark -
#pragma mark initialize / deallocate

- (instancetype)init {
    self = [super init];
    self.mutableCarsQueue = [NSMutableArray object];
    self.occupied = NO;
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

- (NSArray *)cars {
    return [[self.mutableCarsQueue copy] autorelease];
}

#pragma mark -
#pragma mark Public methods

- (void)addCar:(ANSCar *)car {
    NSMutableArray *carsLine = self.mutableCarsQueue;
    if ([self isWashBoxAvailableForCar:car]) {
        [carsLine addObject:car];
    }
    
    if (carsLine.count >= kANSMaxCarCapacity) {
        self.occupied = YES;
    }
}

- (void)removeCar:(ANSCar *)car {
    NSMutableArray *carsLine = self.mutableCarsQueue;
    [carsLine removeObject:car];
    
    if (carsLine.count < kANSMaxCarCapacity) {
        self.occupied = NO;
    }
}

- (ANSCarWasher *)randomWasher {
    NSArray *washers = self.workers;
    NSInteger randomIndex = arc4random_uniform((u_int32_t)(washers.count));
    ANSCarWasher *washer = [washers objectAtIndex:randomIndex];
    
    return washer;
}

- (BOOL)isReadyToUse {
    return !self.isOccupied; //&& self.carsQueue.count < self.workers.count;
}

#pragma mark -
#pragma mark Privat Methods

- (BOOL)isWashBoxAvailableForCar:(ANSCar *)car {
    NSMutableArray *carsLine = self.mutableCarsQueue;
    return carsLine.count < kANSMaxCarCapacity && ![carsLine containsObject:car] ;
}

@end
