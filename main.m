//
//  main.m
//  Objective-C
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSCarWashComplex.h"
#import "NSObject+ANSExtension.h"
#import "ANSCar.h"

int main(int argc, const char * argv[]) {    
    @autoreleasepool {

        ANSCarWashComplex *complex = [ANSCarWashComplex createComplex];
        ANSAdminRoom *adminRoom = [complex washComplexAddAdminRoom];
        ANSWashBox *box = [complex washComplexAddWashBox];
        ANSCarWasher *washer= [complex washComplexAddCarWasher];
        ANSCar *car = [[ANSCar alloc]initWithBalans:10];
        [complex washComplexWashCar:car];
        NSLog(@"hi");
    }
    return 0;
}
