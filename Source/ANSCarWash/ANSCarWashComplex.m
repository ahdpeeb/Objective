//
//  ANSCarWash.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSCarWashComplex.h"

static float kANSServiceCost = 5;

@interface ANSCarWashComplex ()
@property (nonatomic, retain) ANSAdminBuilding *adminBuilding;
@property (nonatomic, retain) ANSWashBuilding *washBuilding;

@end

@implementation ANSCarWashComplex

+ (ANSCarWashComplex *)createComplex; {
    ANSCarWashComplex *complex = [ANSCarWashComplex object];
    if (complex) {
        complex.adminBuilding = [ANSAdminBuilding object];
        complex.washBuilding = [ANSWashBuilding object];
    }
    
    return complex;
}


@end
