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
@property (nonatomic, retain) NSMutableArray *mutableCarsLine;
@property (nonatomic, retain) NSMutableArray *mutableCarWashers;
@property (nonatomic, assign) BOOL           isFullWithCarWasher;
@property (nonatomic, assign) BOOL           isFullWithCars;

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

+ (ANSWashBox *)create; {
    ANSWashBox *box = [ANSWashBox object];
    ANSCarWasher *washer = [ANSCarWasher object];
    [box addCarWasher:washer];
    
    return box;
}

- (NSArray *)carsLine {
    return [[self.mutableCarsLine copy] autorelease];
}

- (NSArray *)carWashers {
    return [[self.mutableCarWashers copy] autorelease];
}

#pragma mark -
#pragma mark Public methods

- (void)addCar:(ANSCar *) car {
    NSMutableArray *carsLine = self.mutableCarsLine;
    
    if (carsLine.count < kANSMaxCarCapacity && ![carsLine containsObject:car]) {
        [carsLine addObject:car];
    }
    
    if (carsLine.count >= kANSMaxCarCapacity) {
        self.isFullWithCars = YES;
    }
}

- (void)removeCar:(ANSCar *) car {
    NSMutableArray *carsLine = self.mutableCarsLine;
    
    if ([carsLine containsObject:car]) {
        [carsLine removeObject:car];
    }
    
    if (carsLine.count < kANSMaxCarCapacity) {
        self.isFullWithCars = NO;
    }
}
    
- (void)addCarWasher:(ANSCarWasher *) washer {
    NSMutableArray *carWashers = self.mutableCarWashers;
    
    if (carWashers.count < kANSMaxCarWasherCapacity && ![carWashers containsObject:washer]) {
        [carWashers addObject:washer];
    }
    
    if(carWashers.count >= kANSMaxCarWasherCapacity) {
        self.isFullWithCarWasher = YES;
    }
}
    
- (void)removeCarWasher:(ANSCarWasher *)washer {
    NSMutableArray *carWashers = self.mutableCarWashers;
    if ([carWashers containsObject:washer]) {
        [carWashers removeObject:washer];
    }
    
    if (carWashers.count < kANSMaxCarWasherCapacity) {
        self.isFullWithCarWasher = NO;
    }
}

- (ANSCarWasher *)randomWasher {
    NSArray *washers = self.carWashers;
    NSInteger randomIndex = arc4random_uniform((u_int32_t)(washers.count));
    ANSCarWasher *washer = [washers objectAtIndex:randomIndex];
    
    return washer;
}

@end
