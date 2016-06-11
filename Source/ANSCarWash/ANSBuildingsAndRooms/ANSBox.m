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
@property (nonatomic, retain) NSMutableArray *mutableCars;

@end

@implementation ANSBox

@dynamic cars;
@dynamic occupied;

#pragma mark -
#pragma mark initialize / deallocate

- (instancetype)init {
    self = [super init];
    self.mutableCars = [NSMutableArray object];
    ANSCarWasher *washer = [ANSCarWasher object];
    [self addWorker:washer];
    
    return self;
}

- (void)dealloc {
    self.mutableCars = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)cars {
    return [[self.mutableCars copy] autorelease];
}

- (BOOL)isOccupied {
    return self.cars.count >= kANSMaxCarCapacity;
}

#pragma mark -
#pragma mark Public methods

- (void)addCar:(ANSCar *)car {
    NSMutableArray *cars = self.mutableCars;
    if (!self.isOccupied && ![cars containsObject:car]) {
        [cars addObject:car];
    }
}

- (void)removeCar:(ANSCar *)car {
    [self.mutableCars removeObject:car];
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

@end
