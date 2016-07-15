    //
//  main.m
//  Objective-C
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSCarWashComplex.h"
#import "ANSComplexDispatcher.h"
#import "ANSGCDTest.h"

#import "ANSKVOtestObserver.h"
#import "ANSThread.h"

#import "NSTimer+ANSExtension.h"
#import "NSObject+ANSExtension.h"

static void *ANSObjectContext = &ANSObjectContext;

int main(int argc, const char * argv[]) {    
    @autoreleasepool {
//        ANSCarWashComplex *complex = [ANSCarWashComplex object];
//       ANSComplexDispatcher *dispatcher = [[ANSComplexDispatcher alloc] initWithComplex:complex];
//        
//        dispatcher.running = YES;
        
    
//        ANSGCDTest *gcd = [[ANSGCDTest alloc] initWithType:DISPATCH_QUEUE_SERIAL];
//        [gcd execute];
//
        ANSTimerBlock block = ^{
            NSLog(@"blia");
        };
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 block:block repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop mainRunLoop] run];
    }
    
    return 0;
}
