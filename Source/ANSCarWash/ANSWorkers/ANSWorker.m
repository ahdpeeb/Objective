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

#import "NSObject+ANSExtension.h"
#import "ANSGCD.h"

@interface ANSWorker ()
@property (atomic, assign)          float           money;
@property (nonatomic, assign)       NSUInteger      ID;
@property (nonatomic, retain)       id<NSLocking>   locker;

- (void)performWorkInBackgroundWithObject:(id)object;
- (void)finishOnMainThreadWorkingWithObject:(id)object;

@end

@implementation ANSWorker

#pragma mark -
#pragma mark Initializetion / deallocation

- (void)dealloc {
    self.locker = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.state = ANSWorkerFree;
    self.locker = [NSLock object];

    return self;
}

- (instancetype)initWithID:(NSUInteger)ID {
    self = [self init];
    self.ID = ID;

    return self;
}

#pragma mark -
#pragma mark Public methods

- (void)receiveMoney:(float)number {
    @synchronized(self) {
        self.money += number;
    }
}

- (void)giveMoney:(float)number {
    @synchronized(self) {
        self.money -= number;
    }
}

- (void)takeMoneyFromObject:(id<ANSMoneyOwner>)owner {
    float money = 0;
    @synchronized(owner) {
        money = owner.money;
        [owner giveMoney:money];
   }
    
    [self receiveMoney:money];
}
//________________________________________________________________________________
- (void)startProcessingObject:(id)object {
    [self performSelectorInBackground:@selector(performWorkInBackgroundWithObject:) withObject:object];
}

#pragma mark -
#pragma mark Private methods

- (void)performWorkInBackgroundWithObject:(id)object {
    [self performWorkWithObject:object];
    
    ANSPerformInMainQueue(dispatch_async, ^{
        [self finishOnMainThreadWorkingWithObject:object];
    });
}

- (void)finishOnMainThreadWorkingWithObject:(id)object {
    [self finishProcessingObject:object];
    [self finishProcessing];
}

- (void)performWorkWithObject:(id)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)finishProcessingObject:(ANSWorker *)object {
    object.state = ANSWorkerFree;
    NSLog(@"%@ - поменял состояние на Free в главном потоке", object);
}

- (void)finishProcessing {
    self.state = ANSWorkerIsPending;
    NSLog(@"%@ - поменял состояние на ANSWorkerIsPending в главном потоке", self);
}

#pragma mark -
#pragma mark Overloaded methods

- (SEL)selectorForState:(NSUInteger)state {
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

#pragma mark -
#pragma mark Redefinition

- (NSString *)description {
    NSString *name = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"ANS" withString:@""];
    
    return [NSString stringWithFormat:@"%@ %ld",name, (long)self.ID];
}

@end
