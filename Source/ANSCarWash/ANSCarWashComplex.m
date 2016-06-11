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

#import "NSObject+ANSExtension.h"

ANSBuilding *office;
ANSBuilding *washing;

@interface ANSCarWashComplex ()
@property (nonatomic, retain) NSMutableArray *mutableRooms;

    //test method
- (id)workerWithClass:(Class)cls;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark initialize / deallocate

- (void)dealloc {
    self.mutableRooms = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableRooms = [NSMutableArray object];
    office = [ANSBuilding object];
    ANSRoom *room = [[[ANSRoom alloc] initWithAccountant:[ANSAccountant object]
                                                    boss:[ANSBoss object]] autorelease];
    [office addRoom:room];
    
    washing = [ANSBuilding object];
    [washing addRoom:[ANSBox object]];
    
    [self.mutableRooms addObject:office];
    [self.mutableRooms addObject:washing];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)rooms {
    return [[self.mutableRooms copy] autorelease];
}

#pragma mark -
#pragma mark Public implementation

- (void)washCar:(ANSCar *)car; {
    ANSBox *freeBox = (ANSBox*)[washing freeRoom];
    if (freeBox) {
        ANSCarWasher *washer = [freeBox randomWasher];
        [freeBox addCar:car];
        [washer washCar:car];
        [freeBox removeCar:car];
        ANSBoss *boss = (ANSBoss *)[self workerWithClass:[ANSBoss class]];
        ANSAccountant *accountant = (ANSAccountant *)[self workerWithClass:[ANSBoss class]];
        [accountant takeMoneyFromObject:washer];
        [boss takeMoneyFromObject:accountant];
    }
}

#pragma mark -
#pragma mark Privat test methods

- (id)workerWithClass:(Class)cls {
    return [[office workersWithClass:cls] firstObject];
}

@end
