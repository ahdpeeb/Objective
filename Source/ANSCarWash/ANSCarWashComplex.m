//
//  ANSCarWash.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWashComplex.h"

#import "ANSCarWasher.h"
#import "ANSAccountant.h"
#import "ANSBoss.h"
#import "ANSConstants.h"
#import "ANSObservableObject.h"
#import "ANSDispatcher.h"

#import "NSObject+ANSExtension.h"
#import "NSArray+ANSExtension.h"
#import "ANSRandom.h"
#import "ANSQueue.h"

@interface ANSCarWashComplex ()
@property (atomic, retain)      ANSQueue                *carQueue;
@property (atomic, retain)      NSMutableArray          *mutableWashers;
@property (nonatomic, retain)   NSMutableArray          *mutableAccountants;
@property (nonatomic, retain)   ANSBoss                 *boss;

@property (nonatomic, retain)   ANSDispatcher           *washersObserver;
@property (nonatomic, retain)   ANSDispatcher           *accountantsObserver;
@property (nonatomic, retain)   ANSDispatcher           *bossObserver;
//@property (nonatomic, retain)   ANSComplexDispatcher    *complexObserver;

- (void)initInfrastructure;
- (NSArray *)freeWorkers;
- (id)reservedFreeWorker;
- (void)startWashingByWasher:(ANSCarWasher*)washer;
- (void)stopObservation;

- (NSMutableArray *)workersWithClass:(Class)cls
                               count:(NSUInteger)count
                           observers:(NSArray *)observers;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark Initializetion / deallocation

- (void)dealloc {
    self.carQueue = nil;
    
    [self stopObservation];
    
    self.mutableWashers = nil;
    self.mutableAccountants = nil;
    self.boss = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self initInfrastructure];
    
    return self;
}

- (void)initInfrastructure {
    self.carQueue = [ANSQueue object];
    [self setObservers];
    
    self.boss = [ANSBoss object];
    [self.boss addObserverObject:self.bossObserver];
    
    self.mutableWashers = [self workersWithClass:[ANSCarWasher class] count:3 observers:nil];
    self.mutableAccountants = [self workersWithClass:[ANSAccountant class] count:2 observers:nil];
}

#pragma mark -
#pragma mark Public implementation

- (void)addCarToQueue:(ANSCar *)car {
    ANSQueue *queue = self.carQueue;
    [queue enqueue:car];
    NSLog(@"%@ - заехала в очередь, кол-во - %lu", car, (unsigned long)queue.count);
    
    @synchronized(self) {
        ANSCarWasher *reserverWasher = [self reservedFreeWorker];
        if (reserverWasher) {
            [self startWashingByWasher:reserverWasher];
        }
    }
}

#pragma mark -
#pragma mark - ANSWorkerObserver protocol

- (void)workerDidBecomeFree:(ANSCarWasher *)worker {
    ANSQueue *queue = worker.queue;
    @synchronized(queue) {
        if (!queue.count) {
            [self startWashingByWasher:worker];
        }
    }
}

#pragma mark -
#pragma mark Private methods

- (NSArray *)freeWorkers {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", @"state", ANSWorkerFree]; //@"busy == NO"
    
    return [self.mutableWashers filteredArrayUsingPredicate:predicate];
}

- (id)reservedFreeWorker {
    @synchronized(self) {
        return [[self freeWorkers] firstObject];
    }
}

- (void)startWashingByWasher:(ANSCarWasher*)washer {
    ANSQueue *carQueue = self.carQueue;
    ANSCar *car = [carQueue dequeue];
    if (car) {
        NSLog(@"%@ начинает мыть %@", washer, car);
        [washer startProcessingObject:car];
    }
}

- (NSMutableArray *)workersWithClass:(Class)cls
                        count:(NSUInteger)count
                    observers:(NSArray *)observers

{
    NSMutableArray *workers = [NSMutableArray object];
    for (NSUInteger value = 0; value < count; value ++) {
        id worker = [[[[cls class] alloc] initWithId:value] autorelease];
        [worker addObserverObjects:observers];
        [workers addObject:worker];
    }
    
    return workers;
}

- (void)setObservers {
    self.washersObserver = [ANSDispatcher object];
    self.accountantsObserver = [ANSDispatcher object];
    self.bossObserver = [ANSDispatcher object];
//    self.complexObserver = [ANSComplexDispatcher object];
}

- (void)removeObservers:(NSArray *)observers fromObjects:(NSArray*)objects {
    for (id object in objects) {
        [object removeObserverObjects:observers];
    }
}

- (void)stopObservation {
    NSMutableArray *washers = self.mutableWashers;
    [self removeObservers:nil fromObjects:washers]; //replace nil for Observers
    
    NSMutableArray *accountants = self.mutableAccountants;
    [self removeObservers:nil fromObjects:accountants]; //replace nil for Observers
    
    [self.boss removeObserverObject:nil]; //replace nil for Observers
}

@end
