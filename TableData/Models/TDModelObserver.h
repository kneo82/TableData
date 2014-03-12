//
//  TDTaskCompletion.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/9/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	kTDModelNotLoaded,
	kTDModelLoading,
	kTDModelLoaded,
    kTDModelUnloaded
} TDModelState;

@protocol TDModelObserver <NSObject>
@optional
- (void)modelWillLoad:(id)object;
- (void)modelDidLoad:(id)object;
- (void)modelDidUnload:(id)object;

@end
