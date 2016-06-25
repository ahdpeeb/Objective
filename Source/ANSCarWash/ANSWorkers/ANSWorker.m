//
//  ANSWorker.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSWorker.h"

#import "ANSCar.h"
#import "ANSRandom.h"

@interface ANSWorker ()
@property (atomic, assign)     float           money;
@property (nonatomic, assign)  NSUInteger      ID;
@property (nonatomic, retain)  NSLock          *locker;

@end

@implementation ANSWorker

#pragma mark -
#pragma mark initialize / deallocate

- (void)dealloc {
    
    [super dealloc];
}

- (instancetype)initWithId:(NSUInteger)ID {
    self = [super init];
    self.ID = ID;
    self.state = ANSWorkerFree;
    self.locker = [[NSLock new] autorelease];
    
    return self;
}

#pragma mark -
#pragma mark Public methods

- (void)receiveMoney:(float)number {
    self.money += number;
}

- (void)giveMoney:(float)number {
    self.money -= number;
}

- (void)takeMoneyFromObject:(id<ANSMoneyOwner>)owner {
        float money = owner.money;
        [owner giveMoney:money];
        [self receiveMoney:money];
}

- (void)processObject:(id)object {
        NSLog(@"%@ - меняет состояние на ANSWorkerBusy", self);
        self.state = ANSWorkerBusy;
        [self performWorkWithObject:object];
        [self performSelectorOnMainThread:@selector(changeStateWithObject:) withObject:object waitUntilDone:YES];
}

- (void)performWorkWithObject:(id)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)changeStateWithObject:(ANSWorker *)object {
    [self doesNotRecognizeSelector:_cmd];
}

#pragma mark -
#pragma mark Overloaded methods

- (SEL)selectorForState:(ANSState)state {
    switch (state) {
        case ANSWorkerBusy:
            return @selector(workerDidBecomeBusy:);
            
        case ANSWorkerIsPending:
            return @selector(workerDidBecomeIsPending:);
            
        case ANSWorkerFree:
            return @selector(workerDidBecomeFree:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
