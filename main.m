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
    
    NSRange alphabetRange = ANSCreateAlphabetRange('A', 'z');
    ANSAlphabet *alphabet = [ANSAlphabet alphabetWithRange:alphabetRange];
    NSLog(@"%@", alphabet);
    
    NSString *value = [alphabet stringAtIndex:2];
    NSLog(@"%@", value);
    
return 0;
}

}