//
//  ANSAccountant.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAccountant.h"

#import "ANSCarWasher.h"

#import "ANSQueue.h"
#import "NSObject+ANSExtension.h"

static const NSUInteger kASNSleepSeconds = 2;

@interface ANSAccountant ()

@end

@implementation ANSAccountant

#pragma mark -
#pragma mark Initializetion / deallocation

- (void)dealloc {
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)countMoney {
    sleep(kASNSleepSeconds);
    NSLog(@"%@ count money - %f ",self, self.money);
}

    // this should be blocked two workers come at the same time
- (void)performWorkWithObject:(id)object {
    @synchronized(self) {
        NSLog(@"%@ cобирается забрать деньги(%f) у %@", self, [object money], object);
        [self takeMoneyFromObject:object];
        [self countMoney];
    }
}
 
- (void)workerDidBecomeIsPending:(id)worker {
    [self.queue enqueue:worker];
    
    @synchronized(self) {
        [self startProcessing];
    }
}

- (void)finishProcessing {
    self.state = ANSWorkerIsPending;
    NSLog(@"%@ - поменял состояние на ANSWorkerIsPending в главном потоке", self);
}

- (void)finishProcessingObject:(id)object {
    [object setState: ANSWorkerFree];
    NSLog(@"%@ - поменял состояние на Free", object);
}

#pragma mark -
#pragma mark Redefinition

- (NSString *)description {
    return [NSString stringWithFormat:@"Accountant %ld", (long)self.ID ];
}

@end
