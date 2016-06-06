//
//  ANSRoom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSWashBox.h"
#import "NSObject+ANSExtension.h"

const NSInteger kANSMaxCarCapacity = 1;
const NSInteger kANSMaxCarWasherCapacity = 1;

@interface ANSWashBox ()
@property (nonatomic, retain, readwrite) NSMutableArray *mutableCarsLine;
@property (nonatomic, retain, readwrite) NSMutableArray *mutableCarWashers;
@property (nonatomic, assign, readwrite) BOOL           isFullWithCarWasher;
@property (nonatomic, assign, readwrite) BOOL           isFullWithCars;

@end

@implementation ANSWashBox

@dynamic carsLine;
@dynamic carWashers;

#pragma mark -
#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mutableCarsLine = [NSMutableArray object];
        self.mutableCarWashers = [NSMutableArray object];
        self.isFullWithCarWasher = NO;
        self.isFullWithCars = NO;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)carsLine {
    return [[self.mutableCarsLine copy] autorelease];
}

- (NSArray *)carWashers {
    return [[self.mutableCarWashers copy] autorelease];
}

#pragma mark -
#pragma mark Public methods

- (void)addCarToRoom:(ANSCar *) car {
    NSMutableArray *carsLine = self.mutableCarsLine;
    
    if (carsLine.count < kANSMaxCarCapacity && ![carsLine containsObject:car]) {
        [carsLine addObject:car];
    }
    
    if (carsLine.count >= kANSMaxCarCapacity) {
        self.isFullWithCars = YES;
    }
}

- (void)removeCarFromRoom:(ANSCar *) car {
    NSMutableArray *carsLine = self.mutableCarsLine;
    
    if ([carsLine containsObject:car]) {
        [carsLine removeObject:car];
    }
    
    if (carsLine.count < kANSMaxCarCapacity) {
        self.isFullWithCars = NO;
    }
}
    
- (void)addCarWasherToRoom:(ANSCarWasher *) washer {
    NSMutableArray *carWashers = self.mutableCarWashers;
    
    if (carWashers.count < kANSMaxCarWasherCapacity && ![carWashers containsObject:washer]) {
        [carWashers addObject:washer];
    }
    
    if(carWashers.count >= kANSMaxCarWasherCapacity) {
        self.isFullWithCarWasher = YES;
    }
}
    
- (void)removeCarWasherFromRoom:(ANSCarWasher *) washer {
    NSMutableArray *carWashers = self.mutableCarWashers;
    if ([carWashers containsObject:washer]) {
        [carWashers removeObject:washer];
    }
    
    if (carWashers.count < kANSMaxCarWasherCapacity) {
        self.isFullWithCarWasher = NO;
    }
}

- (ANSCarWasher *)getRandomWasher {
    NSArray *washers = self.carWashers;
    NSInteger randomIndex = arc4random_uniform((u_int32_t)(washers.count));
    ANSCarWasher *washer = [washers objectAtIndex:randomIndex];
    
    return washer;
}

@end
