//
//  ANSRoom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSRoom.h"
#import "NSObject+ANSExtension.h"
#import "ANSCar.h"

@interface ANSRoom ()
@property (nonatomic, retain, readwrite) NSMutableArray *mutableCarsLine;

@end

@implementation ANSRoom

@dynamic carsLine;

#pragma mark -
#pragma mark Initialization/ dealloc

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mutableCarsLine = [NSMutableArray object];
    }
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)carsLine {
    return [[self.mutableCarsLine copy] autorelease];
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



@end
