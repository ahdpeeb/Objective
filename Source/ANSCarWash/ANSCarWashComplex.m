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

@interface ANSCarWashComplex ()
@property (atomic, retain)      ANSQueue                *carQueue;
@property (atomic, retain)      NSMutableArray          *mutableWashers;
@property (nonatomic, retain)   NSMutableArray          *mutableAccountants;
@property (nonatomic, retain)   NSMutableArray          *mutablebosses;

@property (nonatomic, retain)   ANSDispatcher           *washersDispatcher;
@property (nonatomic, retain)   ANSDispatcher           *accountantsDispatcher;
@property (nonatomic, retain)   ANSDispatcher           *bossesDispatcher;

- (void)initInfrastructure;
- (void)stopObservation;
- (void)conveyCars;
- (NSMutableArray *)objectsWithClass:(Class)cls
                               count:(NSUInteger)count
                           observers:(NSArray *)observers;

- (void)initWorkers;
- (void)initObservers;
- (ANSDispatcher *)initDispatcherWithName:(NSString *)name;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark Initializetion / deallocation

- (void)dealloc {
    [self.carQueue removeObserver:self forKeyPath:@"subjects" context:nil];
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
    [self.carQueue addObserver:self forKeyPath:@"subjects" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    return self;
}

- (void)initInfrastructure {
    self.carQueue = [ANSQueue object];
    [self initObservers];
    [self initWorkers];
}

#pragma mark -
#pragma mark Public implementation

// TEST IMPLEMENTATION
- (void)addCarToQueue:(ANSCar *)car; {
    @synchronized(self) {
        ANSQueue *queue = self.carQueue;
        [queue enqueue:car];
    }
}

#pragma mark -
#pragma mark Private methods

// TEST IMPLEMENTATION
- (void)conveyCars {
    @synchronized(self) {
        ANSQueue *carsQueueu = self.carQueue;
        while (carsQueueu.count) {
            ANSCar *car = [carsQueueu dequeue];
            [self.washersDispatcher processObject:car];
            NSLog(@"%@ - передана обсерверу мойщиков, осталось - %lu машин",car , carsQueueu.count);
        }
    }
}

- (NSMutableArray *)objectsWithClass:(Class)cls
                        count:(NSUInteger)count
                    observers:(NSArray *)observers
{
    NSMutableArray *workers = [NSMutableArray object];
    for (NSUInteger value = 0; value < count; value ++) {
        id worker = [[[[cls class] alloc] initWithID:value] autorelease];
        [worker addObserverObjects:observers];
        [workers addObject:worker];
    }
    
    return workers;
}

- (void)initWorkers {
    ANSDispatcher *washersDispatcher = self.washersDispatcher;
    ANSDispatcher *accountantDispatcher = self.accountantsDispatcher;
    ANSDispatcher *bosseDispatcher = self.bossesDispatcher;
    
    NSMutableArray *(^workersFactory)(Class, NSUInteger, id)  = ^NSMutableArray *(Class cls, NSUInteger count, NSArray *observers) {
        __block NSUInteger ID = 0;
        return [NSMutableArray objectsWithCount:count block: ^id(void) {
            id object = [[[cls alloc] initWithID:ID++] autorelease];
            [object addObserverObjects:observers];
            
            return object;
        }];
    };
    
    NSArray *forWashers = [NSArray arrayWithObjects:washersDispatcher, accountantDispatcher, nil];
    self.mutableWashers = workersFactory([ANSCarWasher class], 4, forWashers);
    [washersDispatcher addProcessors:self.mutableWashers];
    
    NSArray *forAccountants = [NSArray arrayWithObjects:accountantDispatcher, bosseDispatcher, nil];
    self.mutableAccountants = workersFactory([ANSAccountant class], 2, forAccountants);
    [accountantDispatcher addProcessors:self.mutableAccountants];
    
    NSArray *forBosses = [NSArray arrayWithObject:bosseDispatcher];
    self.mutablebosses = workersFactory([ANSBoss class], 1, forBosses);
    [bosseDispatcher addProcessors:self.mutablebosses];
}

- (void)initObservers {
    self.washersDispatcher = [self initDispatcherWithName:@"WashersObserver"];
    self.accountantsDispatcher = [self initDispatcherWithName:@"AccountantsObserver"];
    self.bossesDispatcher = [self initDispatcherWithName:@"bossesObserver"];
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

- (ANSDispatcher *)initDispatcherWithName:(NSString *)name {
    return [[ANSDispatcher alloc] initWithName:name];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"subjects"]) {
        NSLog(@"ВАЖНО! В мойку поступили машины, начать перадачу washersObserver %@", change);
        [self conveyCars];
    }
}

@end
