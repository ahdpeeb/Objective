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
#import "ANSThread.h"

#import "NSObject+ANSExtension.h"

NSUInteger kANSCarCount = 100;
static void *ANSObjectContext = &ANSObjectContext;

int main(int argc, const char * argv[]) {    
    @autoreleasepool {
        ANSCarWashComplex *complex = [ANSCarWashComplex object];
        
        for (NSUInteger count = 0; count < kANSCarCount; count++) {
            ANSCar *car = [[[ANSCar alloc] initWithID:count] autorelease];
            [complex addCarToQueue:car];
        }
//        ANSThread *thread = [ANSThread object];
//        thread.block = ^() {
//            NSLog(@"Blia");
//        };
//        
//        [thread start];
//        
        [[NSRunLoop mainRunLoop] run];
    }
    
    return 0;
}