//
//  main.m
//  Objective-C
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSAlphabet.h"

int main(int argc, const char * argv[]) {    
    @autoreleasepool {
        
        ANSAlphabet *alphabet = [ANSAlphabet alphabetWithRange:ANSCreateAlphabetRange('a', 'b')];
        NSLog(@"%@", [alphabet string]);
        
    return 0;
    }

}