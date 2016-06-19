//
//  ANSAlphabetTest.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 15.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "Kiwi.h"

#import "ANSAlphabet.h"
#import "ANSRangeAlphabet.h"
#import "ANSStringAlphabet.h"
#import "ANSClusterAlphabet.h"

SPEC_BEGIN(ANSAlphabetTest);

describe(@"ANSAlphabet", ^{
    __block ANSAlphabet *alphabet = nil;
    registerMatchers(@"BG"); // Registers BGTangentMatcher, BGConvexMatcher, etc.
    context(@"alphabetWithRange testing", ^{
        beforeAll(^{
            alphabet = [ANSAlphabet alphabetWithRange:ANSCreateAlphabetRange('A', 'Z')];
        });
        
        it(@"should bee kind of class", ^{
            [[alphabet should] beKindOfClass:[ANSRangeAlphabet class]];
        });
        
        it(@"count should be 3", ^{
            [[theValue([alphabet count]) should] equal:theValue(26)];
        });
        
        it(@"should not be empty", ^{
            [[alphabet shouldNot] beEmpty];
        });
        
        it(@"firs symbol should be 'a'", ^{
            [[[alphabet stringAtIndex:2] should] equal:@"C"];
        });
        
        it(@"should respond to selector stringAtIndex", ^{
            [[alphabet should] respondToSelector:@selector(initWithRange:)];
        });
        
        it(@"result from [alphabet string] should be equal to ABCDEFGHIJKLMNOPQRSTUVWXYZ", ^{
            [[[alphabet string] should] equal:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
        });
        
        //alphabet should not bee nil;
        specify(^{
            [[alphabet shouldNot] beNil];
        });
        
        afterAll(^{ // Occurs once at the and
            
        });
        
        context(@"inner context", ^{
            it(@"does another thing", ^{
            });
            
        });
    });
});

SPEC_END
