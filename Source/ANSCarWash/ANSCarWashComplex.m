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

#import "NSObject+ANSExtension.h"
#import "ANSRandom.h"
#import "ANSQueue.h"

@interface ANSCarWashComplex ()
@property (nonatomic, retain) ANSQueue          *carQueue;
@property (nonatomic, retain) ANSAccountant     *accountant;
@property (nonatomic, retain) ANSBoss           *boss;
@property (nonatomic, retain) NSMutableArray    *mutableWashers;

- (void)initInfrastructure;
- (void)washCar:(ANSCar *)car;
- (NSArray *)freeWorkers;
- (id)reservedFreeWorker;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark initializetion / deallocation

- (void)dealloc {
    self.carQueue = nil;
    self.accountant = nil;
    self.boss = nil;
    self.mutableWashers = nil;
    
    //self.washer.delegate = nil;    for all washers.delefate = nil.
    self.accountant.delegate = nil;
    
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
    self.accountant = [ANSAccountant object];
    self.boss = [ANSBoss object];
    self.accountant.delegate = self.boss;
    
    NSUInteger maxCount = ANSRandomIntegerWithValues(3, 5);
    for (NSUInteger count = 0; count < maxCount; count ++) {
        ANSCarWasher *washer = [[[ANSCarWasher alloc] initWithId:count] autorelease];
        washer.delegate = self.accountant;
        [self.mutableWashers addObject:washer];
    }
}

#pragma mark -
#pragma mark Public implementation

- (void)addCarToQueue:(ANSCar *)car {
    ANSQueue *queue = self.carQueue;
    [queue enqueue:car];
    while (queue.count) {
        [self washCar:[queue dequeue]];
    }
}

#pragma mark -
#pragma mark Private methods

- (void)washCar:(ANSCar *)car; {
    ANSCarWasher *reservedWasher = [self reservedFreeWorker];
    reservedWasher.state = ANSWorkerBusy;   // 
        [reservedWasher processObject:car];
}

- (NSArray *)freeWorkers {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", @"state", ANSWorkerFree]; //@"busy == NO"
    return [self.mutableWashers filteredArrayUsingPredicate:predicate];
}

- (id)reservedFreeWorker {
    return [[self freeWorkers] firstObject];
}

@end
