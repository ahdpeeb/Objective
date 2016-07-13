//
//  ANSCarWash.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWashComplex.h"

#import "ANSCarWasher.h"
#import "ANSConstants.h"
#import "ANSDispatcher.h"

#import "NSObject+ANSExtension.h"
#import "NSArray+ANSExtension.h"
#import "ANSRandom.h"
#import "ANSQueue.h"

static NSString * const kANSWashersDispatcher =     @"WashersDispatcher";
static NSString * const kANSAccountantsDispatcher = @"AccountantsDispatcher";
static NSString * const kANSBossesDispatcher =      @"BossesDispatcher";

typedef NSMutableArray *(^ANSWorkersFactory)(Class, NSUInteger, id);

@interface ANSCarWashComplex ()
@property (nonatomic, retain)   ANSQueue                *carQueue;

@property (nonatomic, retain)   ANSDispatcher           *washersDispatcher;
@property (nonatomic, retain)   ANSDispatcher           *accountantsDispatcher;
@property (nonatomic, retain)   ANSDispatcher           *bossesDispatcher;

- (void)initInfrastructure;
<<<<<<< HEAD
- (NSArray *)freeWorkers;
- (id)reservedFreeWorker;
- (void)startWashingByWasher:(ANSCarWasher*)washer;
- (void)stopObservation;
=======
- (void)stopObservation;

- (void)initWorkers;
- (void)initDispatchers;
>>>>>>> feature/Task_8

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark Initialization / deallocation

- (void)dealloc {
    self.carQueue = nil;
    
    [self stopObservation];
    
    self.washersDispatcher = nil;
    self.accountantsDispatcher = nil;
    self.bossesDispatcher = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self initInfrastructure];
    
    return self;
}

- (void)initInfrastructure {
    self.carQueue = [ANSQueue object];
<<<<<<< HEAD
    
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
=======
    [self initDispatchers];
    [self initWorkers];
>>>>>>> feature/Task_8
}

#pragma mark -
#pragma mark Public implementation

<<<<<<< HEAD
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
=======
- (void)addCarToQueue:(ANSCar *)car; {
    [self.washersDispatcher processObject:car];
>>>>>>> feature/Task_8
}

#pragma mark -
#pragma mark Private methods

- (void)initWorkers {
    ANSDispatcher *washersDispatcher = self.washersDispatcher;
    ANSDispatcher *accountantDispatcher = self.accountantsDispatcher;
    ANSDispatcher *bossesDispatcher = self.bossesDispatcher;
    
    ANSWorkersFactory factory  = ^NSMutableArray *(Class cls, NSUInteger count, NSArray *observers) {
        __block NSUInteger ID = 0;
        return [NSMutableArray objectsWithCount:count block: ^id(void) {
            id object = [[[cls alloc] initWithID:ID++] autorelease];
            [object addObserverObjects:observers];
            
            return object;
        }];
    };
    
    [washersDispatcher addProcessors:factory([ANSCarWasher class], 4, [NSArray arrayWithObject:accountantDispatcher])];
    
    [accountantDispatcher addProcessors:factory([ANSAccountant class], 2,[NSArray arrayWithObject:bossesDispatcher])];
    
    [bossesDispatcher addProcessors:factory([ANSBoss class], 1, nil)];
}

<<<<<<< HEAD
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
=======
- (void)initDispatchers {
    self.washersDispatcher = [ANSDispatcher dispatcherWithName:kANSWashersDispatcher];
    self.accountantsDispatcher = [ANSDispatcher dispatcherWithName:kANSAccountantsDispatcher];
    self.bossesDispatcher = [ANSDispatcher dispatcherWithName:kANSBossesDispatcher];
}

- (void)stopObservation {
    NSArray *washers = self.washersDispatcher.processors;
    [washers makeObjectsPerformSelector:@selector(removeObserverObject:) withObject:self.accountantsDispatcher];
    NSArray *accountants = self.accountantsDispatcher.processors;
    [accountants makeObjectsPerformSelector:@selector(removeObserverObject:) withObject:self.bossesDispatcher];
>>>>>>> feature/Task_8
}

@end
