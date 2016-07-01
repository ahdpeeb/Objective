//
//  ANSBoss.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSBoss.h"

static const NSUInteger kASNSleepSeconds = 2;

@implementation ANSBoss

#pragma mark -
#pragma mark initializetion / deallocation

- (instancetype)init {
    self = [super init];
    
    return self;
}

- (void)calculateProfit {
    @synchronized(self) {
        sleep(kASNSleepSeconds);
        NSLog(@"BOSS profir - %f", self.money);
    }
}

- (void)performWorkWithObject:(id)object {
    NSLog(@"%@ забирает деньги(%f) у %@", self, [object money], object);
    [self takeMoneyFromObject:object];
    [self calculateProfit];
}

- (void)workerDidBecomeIsPending:(id)worker {
    [self startProcessingObject:worker];
}

- (void)finishProcessing {
    self.state = ANSWorkerFree;
    NSLog(@"%@ - поменял состояние на Free в главном потоке", self);
}

@end
