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

#import "ANSKVOtest.h"
#import "ANSKVOtestObserver.h"

#import "NSObject+ANSExtension.h"

NSUInteger kANSCarCount = 100;
static void *objectContext = &objectContext;

int main(int argc, const char * argv[]) {    
    @autoreleasepool {
//        ANSCarWashComplex *complex = [ANSCarWashComplex object];
//        
//        for (NSUInteger count = 0; count < kANSCarCount; count++) {
//            ANSCar *car = [[[ANSCar alloc] initWithID:count] autorelease];
//            [complex addCarToQueue:car];
//        }
//        
//        [[NSRunLoop mainRunLoop] run];
//    }
    
        ANSKVOtest *object = [ANSKVOtest object];
        ANSKVOtestObserver *observer = [ANSKVOtestObserver object];
        
        [object addObserver:observer forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        [object addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
     
        object.name = @"Vasia";
        object.name = @"Marina";
        object.age = 13;
        
        [object removeObserver:observer forKeyPath:@"age"];
        [object removeObserver:observer forKeyPath:@"name"];
    }

    return 0;
}