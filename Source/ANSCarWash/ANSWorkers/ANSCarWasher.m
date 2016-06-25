//
//  ANSCarWasher.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWasher.h"

@implementation ANSCarWasher

#pragma mark -
#pragma mark initializetion / deallocation

- (instancetype)init {
    self = [super init];
    self.profession = ANSCarWasherProfession;
    
    return self;
}

- (void)washCar:(ANSCar *)car {
    car.status = ANSCarClean;
NSLog(@"%@ стала чистой", car);
}

- (void)performWorkWithObject:(id)object {
    [self takeMoneyFromObject:object];
NSLog(@"%@ забрал деньги у %@, которую начинает мыть", self, object);
    [self washCar:object];
}

- (void)changeState {
NSLog(@"%@ - меняет состояние на ANSWorkerIsPending и нотифицирует обсерверов", self);
    self.state = ANSWorkerIsPending;
}

#pragma mark -
#pragma mark Redefinition

- (NSString *)description {
    return [NSString stringWithFormat:@"Waser %ld", (long)self.ID ];
}

@end
