//
//  ANSAdminRoom.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANSAccountant.h"
#import "ANSDirector.h"

@interface ANSAdminRoom : NSObject
@property (nonatomic, retain, readonly) ANSAccountant *accountant;
@property (nonatomic, retain, readonly) ANSDirector *direcrot;

- (ANSAccountant *)addAccountantToRoom;
- (void)removeAccountantFromRoom;

- (ANSDirector *)addDirectorToRoom;
- (void)removeDirectorFromRoom;

@end
