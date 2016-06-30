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

@interface ANSWorker ()
@property (atomic, assign)          float           money;
@property (nonatomic, assign)       NSUInteger      ID;
@property (nonatomic, retain)       NSLock          *locker;
@property (nonatomic, retain)       ANSQueue        *queue;

- (void)performWorkInBackgroundWithObject:(id)object;
- (void)finishOnMainThreadWorkingWithObject:(id)object;

@end

@implementation ANSWorker

#pragma mark -
#pragma mark Initializetion / deallocation

- (void)dealloc {
    self.locker = nil;
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.state = ANSWorkerFree;
    self.locker = [NSLock object];
    self.queue = [ANSQueue object];

    return self;
}

- (instancetype)initWithId:(NSUInteger)ID {
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
    @synchronized(self) {
        float money = owner.money;
        [owner giveMoney:money];
        [self receiveMoney:money];
    }
}
//________________________________________________________________________________
- (void)startProcessing {
    @synchronized(self) { 
         if (self.state != ANSWorkerFree) {
             NSLog(@"WARNING %@ состояние = %lu", self, (unsigned long)self.state);
             return;
         }
    
         self.state = ANSWorkerBusy;
         NSLog(@"%@ - поменял состояние на ANSWorkerBusy", self);
         
         ANSQueue *queue = self.queue;
         while (queue.count) {
             id operand = [queue dequeue];
             NSLog(@"%@ достал из очереди объект на обработку %@ ", self, operand);
             [self performSelectorInBackground:@selector(performWorkInBackgroundWithObject:) withObject:operand];
         }
    }
}

#pragma mark -
#pragma mark Private methods

- (void)performWorkInBackgroundWithObject:(id)object {
    [self performWorkWithObject:object];
    [self performSelectorOnMainThread:@selector(finishOnMainThreadWorkingWithObject:) withObject:object waitUntilDone:YES];
}

- (void)finishOnMainThreadWorkingWithObject:(id)object {
    @synchronized(self) {
        [self finishProcessingObject:object];
        [self finishProcessing];
    }
}

- (void)finishProcessingObject:(id)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)finishProcessing {
    [self doesNotRecognizeSelector:_cmd];
}
    
- (void)performWorkWithObject:(id)object {
    [self doesNotRecognizeSelector:_cmd];
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

@end
