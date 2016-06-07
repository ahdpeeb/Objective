//
//  ANSCarWash.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSCar.h"
#import "ANSAdminBuilding.h"
#import "ANSWashBuilding.h"

static const float kANSServiceCost = 5;

@interface ANSCarWashComplex : NSObject
@property (nonatomic, readonly) ANSAdminBuilding    *administrative;
@property (nonatomic, readonly) ANSWashBuilding     *washing;

+ (ANSCarWashComplex *)createComplex;

// Add/ remove rooms to adminBuilding
- (ANSAdminRoom *)washComplexAddAdminRoom;
- (void)washComplexRemoveAdminRoom:(ANSAdminRoom *) room;

// Add/ remove rooms to washBuilding
- (ANSWashBox *)washComplexAddWashBox;
- (void)washComplexRemoveWashBox:(ANSWashBox *) box;

// add/remove carWashers ro boxes
- (ANSCarWasher *)washComplexAddCarWasher;
- (void)washComplexRemoveWasher:(ANSCarWasher *) washer;

// wash car
- (void)washComplexWashCar:(ANSCar *)car;
    
@end
