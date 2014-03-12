//
//  TDTaskCompletionModel.h
//  TableData
//
//  Created by Oleksa Korin on 10/3/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDObservableObject.h"

#import "TDModelObserver.h"

// TODO: Extend the model to handle the failures in loading

@interface TDObervableModel : TDObservableObject
@property (nonatomic, readonly)    TDModelState  state;

// Loads the data into memory
// Notifies observers, that the model started loading, loads the model
// and then notifies observers of loading success
- (void)load;

// Unloads the data from memory and cleans the memory up
// Notifies observers, that the memory was dumped
- (void)dump;

// The notification is performed on main thread
- (void)notifyObserversOfWillLoad;

// The notification is performed on main thread
- (void)notifyObserversOfDidLoad;

// The notification is performed on main thread
- (void)notifyObserversOfDidUnload;

// This method is intended for subclassing purposes only.
// You should never call this method directly
- (void)prepareForLoad;

// This method is intended for subclassing purposes only.
// You should never call this method directly
// You should specify, how the loading is performed inside this method
- (void)performLoading;

// This method is intended for subclassing purposes only.
// You should never call this method directly
// This method should be called manually after the model was loaded
// notifies observers of successful laoding and sets the coresponding state
- (void)finishLoading;

@end
