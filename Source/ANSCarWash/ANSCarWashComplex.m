//
//  ANSCarWash.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWashComplex.h"

#import "ANSBuilding.h"
#import "ANSRoom.h"
#import "ANSCarWasher.h"
#import "ANSAccountant.h"
#import "ANSBoss.h"

#import "NSObject+ANSExtension.h"
#import "ANSQueue.h"

@interface ANSCarWashComplex ()
@property (nonatomic, retain) ANSQueue          *carQueue;
@property (nonatomic, retain) ANSBuilding       *officeBuilding;
@property (nonatomic, retain) ANSBuilding       *washBuilding;

- (void)initInfrastructure;
- (void)washCar:(ANSCar *)car;
- (id)suitableBuildingForWorkerClass:(Class)cls;
- (NSArray *)workersWithClass:(Class)cls;
- (NSArray *)freeWorkerWithClass:(Class)cls;
- (id)reservedFreeWorkerWithClass:(Class)cls;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark initializetion / deallocation

- (void)dealloc {
    self.carQueue = nil;
    self.officeBuilding = nil;
    self.washBuilding = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self initInfrastructure];
    
    return self;
}

- (void)initInfrastructure {
    self.carQueue = [ANSQueue object];
    
    self.officeBuilding = [ANSBuilding object];
    self.washBuilding = [ANSBuilding object];
    
    ANSBuilding *officeBuilding = self.officeBuilding;
    ANSBuilding *washBuilding = self.washBuilding;
    
    ANSAccountant *accountant = [ANSAccountant object];
    ANSBoss *boss = [ANSBoss object];
    ANSCarWasher *washer = [ANSCarWasher object];
    
    washer.delegate = accountant;
    accountant.delegate = boss;
    
    ANSBox *box = [ANSBox object];
    ANSRoom *room = [[[ANSRoom alloc] initWithAccountant:accountant
                                                    boss:boss] autorelease];
    [box addWorker:washer];
    [washBuilding addRoom:box];
    [officeBuilding addRoom:room];
}

#pragma mark -
#pragma mark Public implementation

- (void)addCarToQueue:(ANSCar *)car {
    ANSQueue *queue = self.carQueue;
    [queue enqueue:car];
    while (!queue.count == 0) {
        [self washCar:[queue dequeue]];
    }
}

#pragma mark -
#pragma mark Private methods

- (void)washCar:(ANSCar *)car; {
    ANSBox *freeBox = [self.washBuilding freeRoom];
    if (freeBox) {
        ANSCarWasher *washer = [self reservedFreeWorkerWithClass:[ANSAccountant class]];
        
        [freeBox addCar:car];
        [washer processObject:car];
        [freeBox removeCar:car];
    }
}

- (id)suitableBuildingForWorkerClass:(Class)cls {
    return [cls isSubclassOfClass:[ANSCarWasher class]] ? self.washBuilding : self.officeBuilding;
}
    //! workersWithClass also сontained in ANSBuilding public interfacer
- (NSArray *)workersWithClass:(Class)cls {
    return [[self suitableBuildingForWorkerClass:cls]workersWithClass:cls];
}

- (NSArray *)freeWorkerWithClass:(Class)cls {
    NSArray *workers = [self workersWithClass:cls];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", @"busy", NO]; //@"busy == NO"
    NSArray *result = [workers filteredArrayUsingPredicate:predicate];
    return result;
}

- (id)reservedFreeWorkerWithClass:(Class)cls {
    return [[self freeWorkerWithClass:cls] firstObject];
}

@end
