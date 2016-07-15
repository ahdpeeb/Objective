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
- (void)stopObservation;

- (void)initWorkers;
- (void)initDispatchers;

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
    
    ANSWorkersFactory factory  = ^NSMutableArray *(Class cls, NSUInteger count, id observer) {
        __block NSUInteger ID = 0;
        
        return [NSMutableArray objectsWithCount:count block: ^id(void) {
            id object = [[[cls alloc] initWithID:ID++] autorelease];
            [object addObserverObject:observer];
            
            return object;
        }];
    };
    
    [washersDispatcher addProcessors:factory([ANSCarWasher class], 4, accountantDispatcher)];
    
    [accountantDispatcher addProcessors:factory([ANSAccountant class], 2,bossesDispatcher)];
    
    [bossesDispatcher addProcessors:factory([ANSBoss class], 1, nil)];
}

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
}

@end
