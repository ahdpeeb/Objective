//
//  ANSCarWash.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWashComplex.h"
#import "NSObject+ANSExtension.h"

static NSString * const allBoxesFul = @"No sutable box for car";
static NSString * const noPlaceForWasher = @"No vacansy for washer";

@interface ANSCarWashComplex ()
@property (nonatomic, retain) ANSAdminBuilding *adminBuilding;
@property (nonatomic, retain) ANSWashBuilding *washBuilding;

- (ANSWashBox* )getSuitableBoxForCar;

@end

@implementation ANSCarWashComplex

#pragma mark -
#pragma mark Private implementation

- (ANSWashBox* )getSuitableBoxForCar {
    ANSWashBuilding *washBuilding = self.washBuilding;
    ANSWashBox *sutableBox = nil;
    for (ANSWashBox *box in washBuilding.boxes) {
        if (!box.isFullWithCars && box.isFullWithCarWasher) {
            sutableBox = box;
            break ;
        } else {
            NSLog(@"%@", allBoxesFul);
        }
    }
    
    return sutableBox;
}


#pragma mark -
#pragma mark Public implementation

+ (ANSCarWashComplex *)createComplex; {
    ANSCarWashComplex *washComplex = [ANSCarWashComplex object];
    if (washComplex) {
        washComplex.adminBuilding = [ANSAdminBuilding object];
        washComplex.washBuilding = [ANSWashBuilding object];
    }
    
    return washComplex;
}

- (ANSAdminRoom *)washComplexAddAdminRoom; {
    ANSAdminRoom *room = [ANSAdminRoom object];
    [self.adminBuilding addRoomToAdminBuilding:room];
    [room release];
    
    return room;
}

- (void)washComplexRemoveAdminRoom:(ANSAdminRoom *) room {
    [self.adminBuilding removeRoomsFromAdminBuilding:room];
}


- (ANSWashBox *)washComplexAddWashBox {
    ANSWashBox *box = [ANSWashBox object];
    [self.washBuilding addBoxToWashBuilding:box];
    [box release];
    
    return box;
}

- (void)washComplexRemoveWashBox:(ANSWashBox *) box {
    [self.washBuilding removeBoxFromWashBuilding:box];
}

//__________________________________________________________________________________

- (ANSCarWasher *)washComplexAddCarWasher {
    ANSCarWasher *washer = [ANSCarWasher object];
    ANSWashBuilding *washBuilding = self.washBuilding;
    for (ANSWashBox * washBox in washBuilding.boxes) {
        if (!washBox.isFullWithCarWasher) { // if wash box not full.
            [washBox addCarWasherToRoom:washer];
            break;
        } else {
            NSLog(@"%@", noPlaceForWasher);
        }
    }
    
    [washer release];
    return washer;
}

- (void)washComplexRemoveRemoveWasher:(ANSCarWasher *) washer;
{
    ANSWashBuilding *washBuilding = self.washBuilding;
    for (ANSWashBox * washBox in washBuilding.boxes) {
        [washBox removeCarWasherFromRoom:washer];
    }
}

- (void)washComplexWashCar:(ANSCar* ) car {
    ANSWashBox *suitableBox = [self getSuitableBoxForCar];
    if (suitableBox) {
        ANSCarWasher *washer = [suitableBox getRandomWasher]; // случайный мойщик
        [suitableBox addCarToRoom:car]; // добавил машину в мойку
        [washer washCar:car withCost:kANSServiceCost];
        [suitableBox removeCarFromRoom:car];
    }
}

@end

