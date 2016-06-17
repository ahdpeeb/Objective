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

SPEC_BEGIN(ANSAlphabetTest);

describe(@"ANSAlphabet", ^{
    __block ANSAlphabet *alphabet = nil;
    registerMatchers(@"BG"); // Registers BGTangentMatcher, BGConvexMatcher, etc.
    context(@"alphabetWithRange testing", ^{
        beforeAll(^{
            alphabet = [ANSAlphabet alphabetWithRange:ANSCreateAlphabetRange('a', 'c')];
        });
        
        it(@"should bee kind of class", ^{
            [[alphabet should] beKindOfClass:[ANSRangeAlphabet class]];
        });
        
        it(@"count should be 3", ^{
            [[theValue([alphabet count]) should] equal:theValue(3)];
        });
        
        it(@"should not be empty", ^{
            [[alphabet shouldNot] beEmpty];
        });
        
        it(@"firs symbol should be 'a'", ^{
            [[[alphabet stringAtIndex:2] should] equal:@"c"];
        });
        
        it(@"should respond to selector stringAtIndex", ^{
            [[alphabet should] respondToSelector:@selector(initWithRange:)];
        });
        
        //alphabet should not bee nil;
        specify(^{
            [[alphabet shouldNot] beNil];
        });
        
        afterAll(^{ // Occurs once
            
        });
        
        context(@"inner context", ^{
            it(@"does another thing", ^{
            });
            
            pending(@"something unimplemented", ^{
            });
        });
    });
});

SPEC_END
