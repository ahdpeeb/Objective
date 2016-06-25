//
//  ANSAccountant.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAccountant.h"
#import "ANSCarWasher.h"

static const NSUInteger KASNSleepSeconds = 0;

@implementation ANSAccountant

#pragma mark -
#pragma mark initializetion / deallocation

- (instancetype)init {
    self = [super init];
    
    return self;
}

- (void)countMoney {
    sleep(KASNSleepSeconds);
    NSLog(@"%@ money - %f ",self, self.money);
}
    // this should be blocked two workers come at the same time
- (void)performWorkWithObject:(id)object {
    @synchronized(self) {
        [self takeMoneyFromObject:object];
        NSLog(@"%@ забрал деньги у %@", self, object);
        [self countMoney];
    }
}

- (void)workerDidBecomeIsPending:(id)worker {
    [self performSelectorInBackground:@selector(processObject:) withObject:worker];
}

- (void)changeStateWithObject:(ANSWorker *)object {
    NSLog(@"%@ - меняет состояние на Free", object);
    object.state = ANSWorkerFree;
    NSLog(@"%@ - меняет состояние на ANSWorkerIsPending и нотифицирует обсерверов", self);
    self.state = ANSWorkerIsPending;
}

#pragma mark -
#pragma mark Redefinition

- (NSString *)description {
    return [NSString stringWithFormat:@"Accountant %ld", (long)self.ID ];
}


@end
