//
//  ANSRoom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSWashBox.h"
#import "NSObject+ANSExtension.h"

@interface ANSWashBox ()
@property (nonatomic, retain, readwrite) NSMutableArray *mutableCarsLine;
@property (nonatomic, retain, readwrite) NSMutableArray *mutableCarWashers;

@end

@implementation ANSWashBox

@dynamic carsLine;
@dynamic carWashers;

#pragma mark -
#pragma mark Initialization/ dealloc

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mutableCarsLine = [NSMutableArray object];
        self.mutableCarWashers = [NSMutableArray object];
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
    [self.mutableCarsLine addObject:car];
}

- (void)removeCarFromRoom:(ANSCar *) car {
    [self.mutableCarsLine removeObject:car];
}

- (void)removeCarFromRoomAtIndex:(NSUInteger) index {
    [self.mutableCarsLine removeObjectAtIndex:index];
}

- (void)addCarWasherToRoom:(ANSCarWasher *) washer {
    [self.mutableCarWashers addObject:washer];
}
- (void)removeCarWasherFromRoom:(ANSCarWasher *) washer {
    [self.mutableCarWashers removeObject:washer];
}


@end
