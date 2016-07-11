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
//        ANSCarWashComplex *complex = [ANSCarWashComplex object];
//        
//        NSSet *washerDispatchers = [complex.mutableWashers.firstObject observersSet];
//        NSLog(@"washer - %@", washerDispatchers);
//        
//        NSSet *accountanDispatchers = [complex.mutableAccountants.firstObject observersSet];
//        NSLog(@"accounta - %@", accountanDispatchers);
//        
//        NSSet *bossDispatchers = [complex.mutablebosses.firstObject observersSet];
//        NSLog(@"boss - %@", bossDispatchers);
//        
//        [[ANSComplexDispatcher alloc] initWithComplex:complex];
//        
//        NSRunLoop *loop = [NSRunLoop mainRunLoop];
//        [loop run]; 
//    }
//    
//    return 0;
//}

        ANSThread *thread = [ANSThread object];
        thread.block = ^() {
            NSLog(@"Blia");
        };

        [thread start];

        NSRunLoop *loop = [NSRunLoop mainRunLoop];
        [loop run];
    }

return 0;
}