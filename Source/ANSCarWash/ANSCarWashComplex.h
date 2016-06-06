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

@interface ANSCarWashComplex : NSObject
@property (nonatomic, readonly) ANSAdminBuilding *adminBuilding;
@property (nonatomic, readonly) ANSWashBuilding *washBuilding;

+ (ANSCarWashComplex *)createComplex;

- (ANSAdminRoom *)complexAddAdminRoom:(ANSCarWashComplex *) complex;
- (void)complexRemoveAdminRoom:(ANSCarWashComplex *) complex; // not define

- (ANSWashBox *)complexAddWashBox:(ANSCarWashComplex *) complex;
- (void)complexRemoveWashBox:(ANSCarWashComplex *) complex; //not define

@end
