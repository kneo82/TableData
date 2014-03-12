//
//  TDObservableObject.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/9/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDObservableObject : NSObject
@property (nonatomic, readonly)     NSArray *observers;

- (void)addObserver:(id)object;
- (void)removeObserver:(id)object;

// Notifies with selector, selector all observers with selector
// The selector has to have the following signature - (void)selector:(id)sender
// Self is sent as the |sender|
// The notification is performed on main thread
- (void)notifyObserversWithSelector:(SEL)selector;

// Notifies with selector, selector all observers with selector
// The selector has to have the following signature - (void)selector:(id)sender object:(id)object
// Self is sent as the |sender|, object is sent as |object|
// The notification is performed on main thread
- (void)notifyObserversWithSelector:(SEL)selector object:(id)object;

@end
