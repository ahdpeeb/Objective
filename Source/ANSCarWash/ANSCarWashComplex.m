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
@property (nonatomic, retain)   NSMutableArray          *mutablebosses;

@property (nonatomic, retain)   ANSDispatcher           *washersObserver;
@property (nonatomic, retain)   ANSDispatcher           *accountantsObserver;
@property (nonatomic, retain)   ANSDispatcher           *bossesObserver;
//@property (nonatomic, retain)   ANSComplexDispatcher    *complexObserver;

- (void)initInfrastructure;
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
    self.mutablebosses = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self initInfrastructure];
    
    return self;
}

- (void)initInfrastructure {
    self.carQueue = [ANSQueue object];
    
    ANSDispatcher *washersDispatcher = self.washersObserver;
    ANSDispatcher *accountantDispatcher = self.accountantsObserver;
    ANSDispatcher *bosseDispatcher = self.bossesObserver;
    
    NSArray *forWashers = [NSArray arrayWithObjects:washersDispatcher, accountantDispatcher, nil];
    NSArray *forAccountants = [NSArray arrayWithObjects:accountantDispatcher, bosseDispatcher, nil];
    NSArray *forBosses = [NSArray arrayWithObject:bosseDispatcher];
    
    self.mutableWashers = [self workersWithClass:[ANSCarWasher class] count:3 observers:forWashers];
    self.mutableAccountants = [self workersWithClass:[ANSAccountant class] count:2 observers:forAccountants];
    self.mutablebosses = [self workersWithClass:[ANSBoss class] count:1 observers:forBosses];
    
    [self setObservers];
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
#pragma mark Private methods

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
    self.washersObserver = [[ANSDispatcher alloc] initWithName:@"WashersObserver"];
    self.accountantsObserver = [[ANSDispatcher alloc] initWithName:@"AccountantsObserver"];
    self.bossesObserver = [[ANSDispatcher alloc] initWithName:@"BossObserver"];
//    self.complexObserver = [ANSComplexDispatcher object];
}

- (void)removeObservers:(NSArray *)observers fromObjects:(NSArray*)objects {
    for (id object in objects) {
        [object removeObserverObjects:observers];
    }
}

- (void)stopObservation {
    [self removeObservers:nil fromObjects:self.mutableWashers]; //replace nil for Observers
    [self removeObservers:nil fromObjects:self.mutableAccountants]; //replace nil for Observers
    [self removeObservers:nil fromObjects:self.mutablebosses]; //replace nil for Observers
}

@end
