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
    __block ANSAlphabet *rangeAlphabet = nil;
    __block ANSAlphabet *stringsAlphabet = nil;
    __block ANSAlphabet *clasterAlphabet = nil;
    
    registerMatchers(@"BG"); // Registers BGTangentMatcher, BGConvexMatcher, etc.
    context(@"rangeAlphabet", ^{
        beforeAll(^{
            rangeAlphabet = [ANSAlphabet alphabetWithRange:ANSCreateAlphabetRange('A', 'Z')];
        });
        
        it(@"should bee kind of class", ^{
            [[rangeAlphabet should] beKindOfClass:[ANSRangeAlphabet class]];
        });
        
        it(@"count should be 26", ^{
            [[theValue([rangeAlphabet count]) should] equal:theValue(26)];
        });
        
        it(@"should not be empty", ^{
            [[rangeAlphabet shouldNot] beEmpty];
        });
        
        it(@"firs symbol should be 'C'", ^{
            [[[rangeAlphabet stringAtIndex:2] should] equal:@"C"];
        });
        
        it(@"should respond to selector stringAtIndex", ^{
            [[rangeAlphabet should] respondToSelector:@selector(initWithRange:)];
        });
        
        it(@"result from [alphabet string] should be equal to ABCDEFGHIJKLMNOPQRSTUVWXYZ", ^{
            [[[rangeAlphabet string] should] equal:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
        });
        
        //alphabet should not bee nil;
        specify(^{
            [[rangeAlphabet shouldNot] beNil];
        });
        
        afterAll(^{ // Occurs once at the and
            
        });
    });
    
    context(@"stringsAlphabet", ^{
        beforeAll(^{
            NSString *numericString = [NSString stringWithFormat:@"0123456789"];
            NSString *lowercaseString = [NSString stringWithFormat:@"abc"];
            NSArray *strings = [NSArray arrayWithObjects:numericString, lowercaseString, nil];
            stringsAlphabet = [ANSAlphabet alphabetWithStrings:strings];
        });
        
        it(@"should bee kind of class", ^{
            [[stringsAlphabet should] beKindOfClass:[ANSStringAlphabet class]];
        });
        
        it(@"count should be 2", ^{
            [[theValue([stringsAlphabet count]) should] equal:theValue(2)];
        });
        
        it(@"should not be empty", ^{
            [[stringsAlphabet shouldNot] beEmpty];
        });
        
        it(@"firs symbol should be '2'", ^{
            [[[stringsAlphabet stringAtIndex:0] should] equal:@"0123456789"];
        });
        
        it(@"should respond to selector stringAtIndex", ^{
            [[stringsAlphabet should] respondToSelector:@selector(string)];
        });
        
        it(@"result from [alphabet string] should be equal to ABCDEFGHIJKLMNOPQRSTUVWXYZ", ^{
            [[[stringsAlphabet string] should] equal:@"0123456789abc"];
        });
        
        //alphabet should not bee nil;
        specify(^{
            [[stringsAlphabet shouldNot] beNil];
        });
    });
    
    context(@"clasterAlphabet", ^{
        beforeAll(^{
            NSArray *alphabets = [NSArray arrayWithObjects:rangeAlphabet,stringsAlphabet, nil];
            clasterAlphabet = [ANSAlphabet alphabetWithAlphabets:alphabets];
        });
        
        it(@"should bee kind of class", ^{
            [[clasterAlphabet should] beKindOfClass:[ANSClusterAlphabet class]];
        });
        
        it(@"count should be 28", ^{
            [[theValue([clasterAlphabet count]) should] equal:theValue(28)];
        });
        
        it(@"should not be empty", ^{
            [[clasterAlphabet shouldNot] beEmpty];
        });
        
        it(@"firs symbol should be '2'", ^{
            [[[clasterAlphabet stringAtIndex:0] should] equal:@"A"];
        });
        
        it(@"should respond to selector stringAtIndex", ^{
            [[clasterAlphabet should] respondToSelector:@selector(string)];
        });
        
        it(@"result from [alphabet string] should be equal to ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abc", ^{
            [[[clasterAlphabet string] should] equal:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abc"];
        });
        
        //alphabet should not bee nil;
        specify(^{
            [[clasterAlphabet shouldNot] beNil];
        });
    });
});

SPEC_END
