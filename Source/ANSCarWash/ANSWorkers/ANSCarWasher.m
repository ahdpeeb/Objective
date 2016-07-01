//
//  ANSCarWasher.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWasher.h"

static const NSUInteger kASNSleepSeconds = 0;

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
    [self takeMoneyFromObject:object];
    NSLog(@"%@ забрал деньги у %@, которую начинает мыть", self, object);
    [self washCar:object];
}

- (void)finishProcessingObject:(id)object {
    [object setStatus:ANSCarClean];
    NSLog(@"%@ стала чистой, ее помыл %@", object, self);
}

#pragma mark -
#pragma mark Redefinition

- (NSString *)description {
    return [NSString stringWithFormat:@"Washer %ld", (long)self.ID];
}

@end
