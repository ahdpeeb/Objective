//
//  ANSCarWash.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWashComplex.h"
#import "NSObject+ANSExtension.h"

static NSString * const kANSallBoxesFul =       @"No sutable box for car";
static NSString * const kANSnoPlaceForWasher =  @"No vacansy for washer";

@interface ANSCarWashComplex ()
@property (nonatomic, retain) ANSAdminBuilding  *administrative;
@property (nonatomic, retain) ANSWashBuilding   *washing;

- (ANSWashBox* )freeBox;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark Private implementation

- (ANSWashBox* )freeBox {
    ANSWashBuilding *washBuilding = self.washing;
    ANSWashBox *sutableBox = nil;
    for (ANSWashBox *box in washBuilding.boxes) {
        if (!box.isFullWithCars && box.isFullWithCarWasher) {
            sutableBox = box;
            break ;
        } else {
            NSLog(@"%@", kANSallBoxesFul);
        }
    }
    
    return sutableBox;
}


#pragma mark -
#pragma mark Public implementation

+ (ANSCarWashComplex *)create; {
    ANSCarWashComplex *station = [ANSCarWashComplex object];
    if (station) {
        station.administrative = [ANSAdminBuilding object];
        station.washing = [ANSWashBuilding object];
    }
    
    return station;
}

- (ANSAdminRoom *)washComplexAddAdminRoom; {
    ANSAdminRoom *room = [ANSAdminRoom object];
    [self.administrative addRoomToAdminBuilding:room];
    
    return room;
}

- (void)washComplexRemoveAdminRoom:(ANSAdminRoom *) room {
    [self.administrative removeRoomsFromAdminBuilding:room];
}


- (ANSWashBox *)washComplexAddWashBox {
    ANSWashBox *box = [ANSWashBox object];
    [self.washing addBoxToWashBuilding:box];
    
    return box;
}

- (void)washComplexRemoveWashBox:(ANSWashBox *) box {
    [self.washing removeBoxFromWashBuilding:box];
}

//__________________________________________________________________________________

- (ANSCarWasher *)washComplexAddCarWasher {
    ANSCarWasher *washer = [ANSCarWasher object];
    ANSWashBuilding *washBuilding = self.washing;
    for (ANSWashBox * washBox in washBuilding.boxes) {
        if (!washBox.isFullWithCarWasher) { // if wash box not full.
            [washBox addCarWasherToRoom:washer];
            break;
        } else {
            NSLog(@"%@", kANSnoPlaceForWasher);
        }
    }
    
    [washer release];
    return washer;
}

- (void)washComplexRemoveWasher:(ANSCarWasher *) washer {
    ANSWashBuilding *washBuilding = self.washing;
    for (ANSWashBox * washBox in washBuilding.boxes) {
        [washBox removeCarWasherFromRoom:washer];
    }
}

- (void)washComplexWashCar:(ANSCar* ) car {
    ANSWashBox *suitableBox = [self freeBox];
    if (suitableBox) {
        ANSCarWasher *washer = [suitableBox getRandomWasher]; // случайный мойщик
        [suitableBox addCarToRoom:car]; // добавил машину в мойку
        [washer washCar:car withCost:kANSServiceCost];
        [suitableBox removeCarFromRoom:car];
    }
}

@end

