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

int main(int argc, const char * argv[]) {    
    @autoreleasepool {

        ANSCarWashComplex *complex = [[[ANSCarWashComplex alloc] initInfrastructure] autorelease];
        ANSCar *car = [ANSCar object];
        [complex washCar:car];
        
        NSLog(@"Hi");
    }
    
    return 0;
}

