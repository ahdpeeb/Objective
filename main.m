//
//  main.m
//  Objective-C
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSAlphabet.h"

#import "NSObject+ANSExtension.h"

int main(int argc, const char * argv[]) {    
@autoreleasepool {
    
    NSString *numericString = [NSString stringWithFormat:@"123456789"];
    NSString *lowercaseString = [NSString stringWithFormat:@"abc"];
    NSArray *strings = [NSArray arrayWithObjects:numericString, lowercaseString, nil];
    ANSAlphabet *stringsAlphabet = [ANSAlphabet alphabetWithStrings:strings];
    
    ANSAlphabet *rangeAlphabet = [ANSAlphabet alphabetWithRange:ANSCreateAlphabetRange('A', 'Z')];
    NSString *value = [rangeAlphabet string];
    ANSAlphabet *clasterAlphabet = nil;
    
    NSArray *alphabets = [NSArray arrayWithObjects:rangeAlphabet,stringsAlphabet, nil];
    clasterAlphabet = [ANSAlphabet alphabetWithAlphabets:alphabets];
    
    NSInteger count = clasterAlphabet.count;
    NSLog(@"%ld", (long)count);
    
    
    NSLog(@"%@", value);
        

    
return 0;
}

}