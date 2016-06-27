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
    @synchronized(self) {
        float money = owner.money;
        [owner giveMoney:money];
        [self receiveMoney:money];
     }
}

- (void)processObject:(id)object {
    @synchronized(self) {
        self.state = ANSWorkerBusy;
        NSLog(@"%@ - поменял состояние на ANSWorkerBusy", self);
        [self performWorkWithObject:object];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
        [self changeState];
    });
}

- (void)performWorkWithObject:(id)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)changeState {
    self.state = ANSWorkerIsPending;
    NSLog(@"%@ - поменял состояние на ANSWorkerIsPending и нотифицирует обсерверов", self);
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
