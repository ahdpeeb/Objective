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

#import "NSObject+ANSExtension.h"
#import "ANSRandom.h"
#import "ANSQueue.h"

@interface ANSCarWashComplex ()
@property (atomic, retain)      ANSQueue          *carQueue;
@property (nonatomic, retain)   ANSAccountant     *accountant;
@property (nonatomic, retain)   ANSBoss           *boss;
@property (atomic, retain)      NSMutableArray    *mutableWashers;

- (void)initInfrastructure;
- (NSArray *)freeWorkers;
- (id)reservedFreeWorker;
- (void)startWashingByWasher:(ANSCarWasher*)washer;
- (void)stopObservation;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark Initializetion / deallocation

- (void)dealloc {
    self.carQueue = nil;
    
    [self stopObservation];
    
    self.mutableWashers = nil;
    self.accountant = nil;
    self.boss = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self initInfrastructure];
    
    return self;
}

- (void)initInfrastructure {
    self.mutableWashers = [NSMutableArray object];
    self.carQueue = [ANSQueue object];
    
    ANSAccountant *accountant = [ANSAccountant object];
    self.accountant = accountant;
    
    ANSBoss *boss = [ANSBoss object];
    self.boss = boss;
    [accountant addObserverObject:boss];
    
    NSMutableArray *washers = self.mutableWashers;
    for (NSUInteger count = 0; count < kANSMaxCarWasherCapacity; count ++) {
        ANSCarWasher *washer = [[[ANSCarWasher alloc] initWithId:count] autorelease];
        [washer addObserverObjects:[NSArray arrayWithObjects:accountant, self, nil]];
        [washers addObject:washer];
    }
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
    if (!queue.count) {
        [self startWashingByWasher:worker];
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
    @synchronized(self) {
        ANSQueue *carQueue = self.carQueue;
        ANSCar *car = [carQueue dequeue];
        if (car) {
            NSLog(@"%@ начинает мыть %@", washer, car);
            [washer startProcessingObject:car];
        }
    }
}

- (void)stopObservation {
    NSMutableArray *washers = self.mutableWashers;
    ANSAccountant *accountant = self.accountant;
    for (ANSCarWasher *washer in washers) {
        [washer removeObserverObjects:[NSArray arrayWithObjects:accountant, self, nil]];
    }
    
    [accountant removeObserverObject:self.boss];
}

@end
