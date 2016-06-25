//
//  ANSAccountant.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAccountant.h"
#import "ANSCarWasher.h"

@implementation ANSAccountant

#pragma mark -
#pragma mark initializetion / deallocation

- (instancetype)init {
    self = [super init];
    self.profession = ANSAccountantProfession; 
    
    return self;
}

- (void)countMoney {
    NSLog(@"%@ monet - %f ",self, self.money);
}

- (void)performWorkWithObject:(id)object {
    [self takeMoneyFromObject:object];
NSLog(@"%@ забрал деньги у %@", self, object);
    [self countMoney];
}

- (void)workerDidBecomeIsPending:(id)worker {
    [self processObject:worker];
}

- (void)changeState {
NSLog(@"%@ - меняет состояние на ANSWorkerIsPending и нотифицирует обсерверов", self);
    self.state = ANSWorkerIsPending;
}

#pragma mark -
#pragma mark Redefinition

- (NSString *)description {
    return [NSString stringWithFormat:@"Accountant %ld", (long)self.ID ];
}


@end
