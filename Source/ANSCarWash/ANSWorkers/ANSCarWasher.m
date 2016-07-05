//
//  ANSCarWasher.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWasher.h"

#import "ANSConstants.h"

@implementation ANSCarWasher

#pragma mark -
#pragma mark Public methods

- (void)washCar:(ANSCar *)car {
    usleep(kASNSleepSeconds);
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
