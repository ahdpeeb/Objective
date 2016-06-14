//
//  ANSCarWash.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWashComplex.h"

#import "ANSRoom.h"
#import "ANSAccountant.h"
#import "ANSBoss.h"

#import "NSObject+ANSExtension.h"

@interface ANSCarWashComplex ()
@property (nonatomic, retain) NSMutableArray    *mutableBuildings;
@property (nonatomic, retain) ANSBuilding       *officeBuilding;
@property (nonatomic, retain) ANSBuilding       *washBuilding ;

    //test method
- (id)workerWithClass:(Class)cls;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark initialize / deallocate

- (void)dealloc {
    self.mutableBuildings = nil;
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
    self.mutableBuildings = [NSMutableArray object];
    NSMutableArray *buildings = self.mutableBuildings;
    
    self.officeBuilding = [ANSBuilding object];
    self.washBuilding = [ANSBuilding object];
    
    [buildings addObject:self.officeBuilding];
    [buildings addObject:self.washBuilding];
    ANSRoom *room = [[[ANSRoom alloc] initWithAccountant:[ANSAccountant object]
                                                    boss:[ANSBoss object]] autorelease];
    [self.officeBuilding addRoom:room];
    [self.washBuilding addRoom:[ANSBox object]];
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)rooms {
    return [[self.mutableBuildings copy] autorelease];
}

#pragma mark -
#pragma mark Public implementation

- (void)washCar:(ANSCar *)car; {
    ANSBox *freeBox = [self.washBuilding freeRoom];
    if (freeBox) {
        ANSCarWasher *washer = [freeBox randomWasher];
        ANSBoss *boss = [self workerWithClass:[ANSBoss class]];
        ANSAccountant *accountant = [self workerWithClass:[ANSAccountant class]];
        
        [freeBox addCar:car];
        
        [washer processObject:car];
        [accountant processObject:washer];
        [boss processObject:accountant];
        
        [freeBox removeCar:car];
    }
}

#pragma mark -
#pragma mark Private test methods

- (id)workerWithClass:(Class)cls {
    return [[self.officeBuilding workersWithClass:cls] firstObject];
}

@end
