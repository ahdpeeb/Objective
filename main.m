    //
//  main.m
//  Objective-C
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSCarWashComplex.h"
#import "ANSWorker.h"

#import "NSObject+ANSExtension.h"

int main(int argc, const char * argv[]) {    
    @autoreleasepool {
        ANSCarWashComplex *complex = [ANSCarWashComplex object];
        
        for (NSUInteger count = 0; count < 4; count++) {
            ANSCar *car = [[ANSCar alloc] initWithID:count];
            [complex addCarToQueue:car];
        }
    }
    
    return 0;
}