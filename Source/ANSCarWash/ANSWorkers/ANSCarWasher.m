//
//  ANSCarWasher.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWasher.h"

static const NSUInteger kASNSleepSeconds = 1;

@implementation ANSCarWasher

#pragma mark -
#pragma mark initializetion / deallocation

- (instancetype)init {
    self = [super init];
    
    return self;
}

- (void)washCar:(ANSCar *)car {
    sleep(kASNSleepSeconds);
}

- (void)performWorkWithObject:(id)object {
    NSLog(@"%@ забирает деньги у %@, которую начинает мыть", self, object);
    [self takeMoneyFromObject:object];
    [self washCar:object];
}

- (void)finishProcessingObject:(ANSCar *)car {
    car.status = ANSCarClean;
    NSLog(@"%@ стала чистой, ее помыл %@", car, self);
}

@end
