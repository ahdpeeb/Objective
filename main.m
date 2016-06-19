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
    
    NSMutableString *mutableString = [NSMutableString object];
    
    NSRange alphabetRange = ANSCreateAlphabetRange('A', 'Z');
    ANSAlphabet *alphabet = [ANSAlphabet alphabetWithRange:alphabetRange];
    NSString *value = [alphabet string];
    NSLog(@"%@", value);
    
    for (id value in alphabet) {
        [mutableString appendFormat:@"%@", value];
    }
    
    NSLog(@"%@", mutableString);
    
return 0;
}

}