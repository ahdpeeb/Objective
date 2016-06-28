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

static const NSUInteger KASNSleepSeconds = 2;

@interface ANSAccountant ()
@property (nonatomic, retain) ANSQueue *queue;

@end

@implementation ANSAccountant

#pragma mark -
#pragma mark Initializetion / deallocation

- (void)dealloc {
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.queue = [ANSQueue object];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)countMoney {
    sleep(KASNSleepSeconds);
    NSLog(@"%@ count money - %f ",self, self.money);
}

    // this should be blocked two workers come at the same time
- (void)performWorkWithObject:(id)object {
    @synchronized(self) {
        ANSQueue *queue = self.queue;
        while (queue.count) {
            id washer = [queue dequeue];
            NSLog(@"%@ cобирается забрать деньги(%f) у %@", self, [object money], object);
            [self takeMoneyFromObject:washer];
        }
        
        [self countMoney];
    }
}
 
- (void)workerDidBecomeIsPending:(id)worker {
    [self.queue enqueue:worker];
    [self processObject:worker];
}

- (void)changeStateWithObject:(id)object {
    self.state = ANSWorkerIsPending;
    NSLog(@"%@ - поменял состояние на Free в главном потоке", self);
    
    [object setState: ANSWorkerFree];
    NSLog(@"%@ - поменял состояние на Free", object);
}

#pragma mark -
#pragma mark Redefinition

- (NSString *)description {
    return [NSString stringWithFormat:@"Accountant %ld", (long)self.ID ];
}

@end
