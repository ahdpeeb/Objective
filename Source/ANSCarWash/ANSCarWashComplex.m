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
- (instancetype)firsWorkerWithClass:(Class)class;

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
        ANSBoss *boss = (ANSBoss *)[self firsWorkerWithClass:[ANSBoss class]];
        ANSAccountant *accountant = (ANSAccountant *)[self firsWorkerWithClass:[ANSBoss class]];
        [accountant takeMoneyFromObject:washer];
        [boss takeMoneyFromObject:accountant];
    }
}

#pragma mark -
#pragma mark Privat test methods

- (instancetype)firsWorkerWithClass:(Class)class {
    NSArray *array = [office workersWithClass:class];
    if (array.count != 0) {
        return [array objectAtIndex:0];
    }
    
    return nil;
}

@end
