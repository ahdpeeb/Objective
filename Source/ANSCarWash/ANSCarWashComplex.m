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
@property (nonatomic, retain)   ANSQueue                *carQueue;

@property (nonatomic, retain)   ANSDispatcher           *washersDispatcher;
@property (nonatomic, retain)   ANSDispatcher           *accountantsDispatcher;
@property (nonatomic, retain)   ANSDispatcher           *bossesDispatcher;

- (void)initInfrastructure;
- (void)stopObservation;

- (void)initWorkers;
- (void)initDispatchers;
- (ANSDispatcher *)initDispatcherWithName:(NSString *)name;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark Initialization / deallocation

- (void)dealloc {
    self.carQueue = nil;
    
    [self stopObservation];
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self initInfrastructure];
    
    return self;
}

- (void)initInfrastructure {
    self.carQueue = [ANSQueue object];
    [self initDispatchers];
    [self initWorkers];
}

#pragma mark -
#pragma mark Public implementation

- (void)addCarToQueue:(ANSCar *)car; {
    [self.washersDispatcher processObject:car];
}

#pragma mark -
#pragma mark Private methods

- (void)initWorkers {
    ANSDispatcher *washersDispatcher = self.washersDispatcher;
    ANSDispatcher *accountantDispatcher = self.accountantsDispatcher;
    ANSDispatcher *bossesDispatcher = self.bossesDispatcher;
    
    NSMutableArray *(^workersFactory)(Class, NSUInteger, id)  = ^NSMutableArray *(Class cls, NSUInteger count, NSArray *observers) {
        __block NSUInteger ID = 0;
        return [NSMutableArray objectsWithCount:count block: ^id(void) {
            id object = [[[cls alloc] initWithID:ID++] autorelease];
            [object addObserverObjects:observers];
            
            return object;
        }];
    };

    [washersDispatcher addProcessors:workersFactory([ANSCarWasher class], 4, [NSArray arrayWithObject:accountantDispatcher])];
    
    [accountantDispatcher addProcessors:workersFactory([ANSAccountant class], 2,[NSArray arrayWithObject:bossesDispatcher])];
    
    [bossesDispatcher addProcessors:workersFactory([ANSBoss class], 1, nil)];
}

- (void)initDispatchers {
    self.washersDispatcher = [ANSDispatcher dispatcherWithName:@"WashersDispatcher"];
    self.accountantsDispatcher = [ANSDispatcher dispatcherWithName:@"AccountantsDispatcher"];
    self.bossesDispatcher = [ANSDispatcher dispatcherWithName:@"bossesDispatcher"];
}

- (void)removeObservers:(NSArray *)observers fromObjects:(NSArray*)objects {
    for (id object in objects) {
        [object removeObserverObjects:observers];
    }
}

- (void)stopObservation {
    [self removeObservers:[NSArray arrayWithObject:self.accountantsDispatcher] fromObjects:nil];
    [self removeObservers:[NSArray arrayWithObject:self.accountantsDispatcher] fromObjects:nil];
}

@end
