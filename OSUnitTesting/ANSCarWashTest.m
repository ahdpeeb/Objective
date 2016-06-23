//
//  ANSCarWashTest.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 23.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "Kiwi.h"

#import "ANSCarWashComplex.h"

#import "NSObject+ANSExtension.h"

SPEC_BEGIN(ANSCarWashTest);

describe(@"ANSCarWashComplex", ^{
    __block ANSCarWashComplex *complex = nil;
    __block ANSCar *car = nil;
    
    registerMatchers(@"BG"); // Registers BGTangentMatcher, BGConvexMatcher, etc.
    context(@"ANSCarWashComplex", ^{
        beforeAll(^{
            complex = [ANSCarWashComplex object];
            car = [ANSCar object];
        });
        
        it(@"should bee kind of class", ^{
            
        });
        
        it(@"count should be 26", ^{
        
        });
        
        it(@"should not be empty", ^{
            
        });
        
        it(@"firs symbol should be 'C'", ^{
            
        });
        
        it(@"should respond to selector stringAtIndex", ^{
            
        });
        
        it(@"result from [alphabet string] should be equal to ABCDEFGHIJKLMNOPQRSTUVWXYZ", ^{
            
        });
        
        //alphabet should not bee nil;
        specify(^{
            [[complex shouldNot] beNil];
            [[car shouldNot] beNil];
        });
        
        afterAll(^{ // Occurs once at the and
            
        });
    });
});

SPEC_END

