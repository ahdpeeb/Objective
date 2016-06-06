//
//  ANSWashBuilding.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANSWashBox.h"

@interface ANSWashBuilding : NSObject

@property (nonatomic, readonly) NSArray *boxes;

- (void)addBoxToWashBuilding:(ANSWashBox *) box;
- (void)removeBoxFromWashBuilding:(ANSWashBox *) box;

@end
