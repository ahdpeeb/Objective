//
//  ANSCarWasher.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWasher.h"

static const NSUInteger KASNSleepSeconds = 1;

@implementation ANSCarWasher

#pragma mark -
#pragma mark initializetion / deallocation

- (instancetype)init {
    self = [super init];
    
    return self;
}

- (void)washCar:(ANSCar *)car {
    sleep(KASNSleepSeconds);
    car.status = ANSCarClean;
    NSLog(@"%@ стала чистой", car);
}

- (void)performWorkWithObject:(id)object {
    [self takeMoneyFromObject:object];
    NSLog(@"%@ забрал деньги у %@, которую начинает мыть", self, object);
    [self washCar:object];
}

#pragma mark -
#pragma mark Redefinition

- (NSString *)description {
    return [NSString stringWithFormat:@"Waser %ld", (long)self.ID ];
}

@end
