//
//  ANSFindingObject.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 09.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ANSFindingObject <NSObject>

@optional

- (NSArray *)objectsWithClass:(Class<ANSFindingObject>)anyClass;

@end
