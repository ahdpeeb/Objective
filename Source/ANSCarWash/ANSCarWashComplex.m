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
@property (atomic, retain)      NSMutableArray    *mutableWashers;
@property (nonatomic, retain)   NSMutableArray    *mutableAccountants;
@property (nonatomic, retain)   ANSBoss           *boss;

- (void)initInfrastructure;
- (NSArray *)freeWorkers;
- (id)reservedFreeWorker;
- (void)startWashingByWasher:(ANSCarWasher*)washer;
- (void)ripObservation;

- (NSArray *)workersWithClass:(Class)cls
                        count:(NSUInteger)count
                    observers:(NSArray *)observers;
@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark Initializetion / deallocation

- (void)dealloc {
    self.carQueue = nil;
    
    [self ripObservation];
    
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
    
    self.boss = [ANSBoss object];
    [self.boss addObserverObject:nil];
    
    NSArray *carWashers = [self workersWithClass:[ANSCarWasher class] count:kANSMaxCarWashersCapacity observers:nil];
    NSArray *accountants = [self workersWithClass:[ANSAccountant class] count:kANSMaxAccountantsCapacity observers:nil];
    
    self.mutableWashers = [NSMutableArray arrayWithArray:carWashers];
    self.mutableAccountants = [NSMutableArray arrayWithArray:accountants];
}

#pragma mark -
#pragma mark Public implementation

- (void)addCarToQueue:(ANSCar *)car {
    ANSQueue *queue = self.carQueue;
    [queue enqueue:car];
    NSLog(@"%@ - заехала в очередь, кол-во - %lu", car, (unsigned long)queue.count);
    
    ANSAccountant *account = self.accountant;
    @synchronized(account) {
        if (account.queue.count == kANSMaxCarWasherCapacity) {
            [account processObjects];
        }
    }
    
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
    // It should be oberride
- (void)ripObservation {
    NSMutableArray *washers = self.mutableWashers;
    ANSAccountant *accountant = self.accountant; // need to be changed
    for (ANSCarWasher *washer in washers) {
        [washer removeObserverObjects:[NSArray arrayWithObjects:accountant, self, nil]];
    }
    
    [accountant removeObserverObject:self.boss];
}

- (NSArray *)workersWithClass:(Class)cls
                        count:(NSUInteger)count
                    observers:(NSArray *)observers

{
    NSMutableArray *workers = [NSMutableArray object];
    for (NSUInteger value = 0; value < count; value ++) {
        ANSWorker *worker = [[[[cls class] alloc] initWithId:count] autorelease];
        [worker addObserverObjects:observers];
        [workers addObject:worker];
    }
    
    return [[workers copy] autorelease];
}

@end
