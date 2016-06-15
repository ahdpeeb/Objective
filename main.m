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
#import "NSString+ANSExtension.h"

int main(int argc, const char * argv[]) {    
    @autoreleasepool {
        
        ANSCarWashComplex *comples = [ANSCarWashComplex object];
        ANSCar *car = [ANSCar object];
        
        [comples washCar:car];
        
    return 0;
    }

}