//
//  ANSBoss.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSBoss.h"

#import "ANSConstants.h"

@implementation ANSBoss

#pragma mark -
#pragma mark Public methods

- (void)calculateProfit {
    usleep(kASNSleepSeconds);
    NSLog(@"BOSS profir - %f", self.money);
}

- (void)performWorkWithObject:(id)object {
    NSLog(@"%@ забирает деньги(%f) у %@", self, [object money], object);
    [self takeMoneyFromObject:object];
    [self calculateProfit];
}

- (void)finishProcessing {
    self.state = ANSWorkerFree;
    NSLog(@"%@ - поменял состояние на Free в главном потоке", self);
}

- (void)finishProcessingObject:(ANSWorker *)object {
    if (object.queue.count == kANSMaxCarWasherCapacity) {
        [object processObjects];
    }
    
    object.state = ANSWorkerFree;
    NSLog(@"%@ - поменял состояние на Free в главном потоке", object);
}

@end
