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

- (void)initInfrastructure;
- (void)stopObservation;
- (void)conveyCars;

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
    
    [self setObservers];
    
    ANSDispatcher *washersDispatcher = self.washersObserver;
    ANSDispatcher *accountantDispatcher = self.accountantsObserver;
    ANSDispatcher *bosseDispatcher = self.bossesObserver;
    
    NSArray *forWashers = [NSArray arrayWithObjects:washersDispatcher, accountantDispatcher, nil];
    self.mutableWashers = [self objectsWithClass:[ANSCarWasher class] count:3 observers:forWashers];
    
    NSArray *forAccountants = [NSArray arrayWithObjects:accountantDispatcher, bosseDispatcher, nil];
    self.mutableAccountants = [self objectsWithClass:[ANSAccountant class] count:2 observers:forAccountants];
    
    NSArray *forBosses = [NSArray arrayWithObject:bosseDispatcher];
    self.mutablebosses = [self objectsWithClass:[ANSBoss class] count:1 observers:forBosses];
    
    [washersDispatcher addProcessors:self.mutableWashers];
    [accountantDispatcher addProcessors:self.mutableAccountants];
    [bosseDispatcher addProcessors:self.mutablebosses];
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

- (void)conveyCars {
    @synchronized(self) {
        ANSQueue *carsQueueu = self.carQueue;
        while (carsQueueu.count) {
            ANSCar *car = [carsQueueu dequeue];
            [self.washersObserver processObject:car];
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
        id worker = [[[[cls class] alloc] initWithId:value] autorelease];
        [worker addObserverObjects:observers];
        [workers addObject:worker];
    }
    
    return workers;
}

- (void)setObservers {
//    NSArray *observers = [NSArray arrayWithObjects:self.washersObserver, self.accountantsObserver, self.bossesObserver, nil];
//    NSArray *names = [NSArray arrayWithObjects:@"WashersObserver", @"AccountantsObserver", @"BossObserver", nil];
//    for (NSUInteger index = 0; index < [names count]; index++) {
//        id object = observers[index];
//        object = [[[[object class] alloc] initWithName:names[index]] autorelease];
//    }

    self.washersObserver = [[[ANSDispatcher alloc] initWithName:@"WashersObserver"] autorelease];
    self.accountantsObserver = [[[ANSDispatcher alloc] initWithName:@"AccountantsObserver"] autorelease];
    self.bossesObserver = [[[ANSDispatcher alloc] initWithName:@"BossObserver"] autorelease];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"subjects"]) {
        NSLog(@"ВАЖНО! В мойку поступили машины, начать перадачу washersObserver %@", change);
        [self conveyCars];
    }
}

@end
