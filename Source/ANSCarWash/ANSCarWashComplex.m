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
@property (atomic, retain)    NSMutableArray    *mutableWashers;

- (void)initInfrastructure;
- (void)washCar:(ANSCar *)car;
- (NSArray *)freeWorkers;
- (id)reservedFreeWorker;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark Initializetion / deallocation

- (void)dealloc {
    self.carQueue = nil;
    NSMutableArray *washers = self.mutableWashers;
    ANSAccountant *accountant = self.accountant;
    
    [washers makeObjectsPerformSelector:@selector(removeObserverObject:) withObject:accountant];
    [accountant removeObserverObject:self.boss];
    
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
    self.accountant = [ANSAccountant object];
    self.boss = [ANSBoss object];
    ANSAccountant *accountant = self.accountant;
    [accountant addObserverObject:self.boss];
    
//    NSUInteger maxCount = ANSRandomIntegerWithValues(3, 5); // temporary do not use.
    for (NSUInteger count = 0; count < 2; count ++) {
        ANSCarWasher *washer = [[[ANSCarWasher alloc] initWithId:count] autorelease];
        [washer addObserverObject:accountant];
        [self.mutableWashers addObject:washer];
    }
}

#pragma mark -
#pragma mark Public implementation

- (void)addCarToQueue:(ANSCar *)car {
    ANSQueue *queue = self.carQueue;
    [queue enqueue:car];
NSLog(@"%@ - заехала в очередь", car);
    while (queue.count) {
        ANSCar *car = [queue dequeue];
NSLog(@"%@ - достали из очереди, чтоб помыть", car);
        [self washCar:car];
    }
}

#pragma mark -
#pragma mark Private methods

- (void)washCar:(ANSCar *)car; {
    ANSCarWasher *reservedWasher = [self reservedFreeWorker];
    if (reservedWasher) {
        NSLog(@"%@ начинает мыть %@", reservedWasher, car);
        [reservedWasher processObject:car];
    }
}

- (NSArray *)freeWorkers {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", @"state", ANSWorkerFree]; //@"busy == NO"
    return [self.mutableWashers filteredArrayUsingPredicate:predicate];
}

- (id)reservedFreeWorker {
    return [[self freeWorkers] firstObject];
}

@end
