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
        
//        ANSCar *car1 = [ANSCar object];
//        [car1 setValue:ANSCarClean forKey:@"status"];
//        NSUInteger value = (NSUInteger)car1.status;
//        ANSCar *car2 = [ANSCar object];
//        ANSCar *car3 = [ANSCar object];
//        ANSCar *car4 = [ANSCar object];
//        [car4 setValue:ANSCarClean forKey:@"status"];
//        NSArray *array = @[car1, car2, car3, car4];
//        
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %lu", @"status", ANSCarClean];
//        NSArray *result = [array filteredArrayUsingPredicate:predicate];
//        NSLog(@"%@", result);
//
        
        ANSCarWashComplex *complex = [ANSCarWashComplex object];
        ANSCar *car = [ANSCar object];
        [complex addCarToQueue:car];
        
        
        return 0;
    }

}