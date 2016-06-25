//
//  ANSBoss.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSBoss.h"

@implementation ANSBoss

#pragma mark -
#pragma mark initializetion / deallocation

- (instancetype)init {
    self = [super init];
    
    return self;
}

- (void)calculateProfit {
    NSLog(@"BOSS profir - %f", self.money);
}

- (void)performWorkWithObject:(id)object {
    [self takeMoneyFromObject:object];
    NSLog(@"%@ забрал деньги у %@", self, object);
    [self calculateProfit];
}

- (void)workerDidBecomeIsPending:(id)worker {
    [self performSelectorInBackground:@selector(processObject:) withObject:worker];
}

- (void)changeStateWithObject:(ANSWorker *)object {
NSLog(@"%@ - меняет состояние на Free", object);
    object.state = ANSWorkerFree;
NSLog(@"%@ - меняет состояние на Free", self);
    self.state = ANSWorkerFree;
}

#pragma mark -
#pragma mark Redefinition

- (NSString *)description {
    return [NSString stringWithFormat:@"Boss %ld", (long)self.ID ];
}

@end
