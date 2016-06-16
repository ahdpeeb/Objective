//
//  ANSClasterAlphabet.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 12.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSClasterAlphabet.h"

@interface ANSClasterAlphabet ()


@end
@implementation ANSClasterAlphabet

#pragma mark -
#pragma mark Initialization and deallocation

#pragma mark -
#pragma mark Public


- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id [])buffer
                                    count:(NSUInteger)len
{
    return [super countByEnumeratingWithState:state
                                      objects:buffer
                                        count:len];
}

#pragma mark -
#pragma mark Private

@end