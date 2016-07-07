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
#import "ANSCarWasher.h"
#import "ANSCar.h"
#import "ANSComplexDispatcher.h"

#import "ANSKVOtest.h"
#import "ANSKVOtestObserver.h"
#import "ANSThread.h"

#import "NSObject+ANSExtension.h"

static void *ANSObjectContext = &ANSObjectContext;

int main(int argc, const char * argv[]) {    
    @autoreleasepool {
        ANSCarWashComplex *complex = [ANSCarWashComplex object];
        
        NSSet *washerObservers = [complex.mutableWashers.firstObject observersSet];
        NSLog(@"washerObservers - %@", washerObservers);
        
        NSSet *accountanObservers = [complex.mutableAccountants.firstObject observersSet];
        NSLog(@"accountanObservers - %@", accountanObservers);
        
        NSSet *bossObservers = [complex.mutablebosses.firstObject observersSet];
        NSLog(@"bossObservers - %@", bossObservers);
        
        ANSComplexDispatcher *dispatcher = [ANSComplexDispatcher object];
        
        ANSCar *car = [[ANSCar alloc] initWithID:1];
        
        [complex addCarToQueue:car];
        
        [[NSRunLoop mainRunLoop] run];
    }
    
    return 0;
}

//        ANSThread *thread = [ANSThread object];
//        thread.block = ^() {
//            NSLog(@"Blia");
//        };
//
//        [thread start];
//