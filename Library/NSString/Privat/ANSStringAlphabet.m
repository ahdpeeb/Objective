//
//  ANSStringAlphabet.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 12.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSStringAlphabet.h"

@interface ANSStringAlphabet ()
@property (nonatomic, retain) NSArray *strings;

@end

@implementation ANSStringAlphabet

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.strings = nil;
    
    [super dealloc];
}

- (instancetype)initWithArray:(NSArray *)strings {
    self = [super init];
    if (self) {
        self.strings = strings;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSUInteger)count {
    return self.strings.count;
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    return self.strings[index];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id [])buffer
                                    count:(NSUInteger)len
{
    return [self.strings countByEnumeratingWithState:state
                                             objects:buffer
                                               count:len];
}

@end
