//
//  EventTapXPCService.m
//  EventTapXPCService
//
//  Created by Chris Ballinger on 2/4/18.
//  Copyright © 2018 Yoshimasa Niwa. All rights reserved.
//

#import "EventTapXPCService.h"
#import "HTKEventTap.h"
#import "HTKTapGestureEventListener.h"
#import "HTKFunctionKeyEventListener.h"
#import "HTKEvent.h"
#import "HTKMultitouchActuator.h"

@import os.log;

NS_ASSUME_NONNULL_BEGIN
@interface EventTapXPCService() <HTKEventListenerDelegate>
@property (nonatomic, nullable) HTKEventListener *eventListener;
@end

@implementation EventTapXPCService

- (instancetype) init {
    if (self = [super init]) {
        [NSProcessInfo processInfo].automaticTerminationSupportEnabled = YES;
        [[NSProcessInfo processInfo] disableAutomaticTermination:NSStringFromClass(self.class)];
        
    }
    return self;
}

- (void) setupGestureListener {
    _eventListener = [[HTKTapGestureEventListener alloc] init];
    [self commonSetup];
}

- (void) setupFunctionKeyListener {
    _eventListener = [[HTKFunctionKeyEventListener alloc] init];
    [self commonSetup];
}

- (void) commonSetup {
    self.eventListener.delegate = self;
    [self startListening];
}

- (void) teardown {
    [self stopListening];
    _eventListener = nil;
    [[NSProcessInfo processInfo] enableAutomaticTermination:NSStringFromClass(self.class)];
    [[NSProcessInfo processInfo] enableSuddenTermination];
}


- (void) startListening {
    _eventListener.enabled = YES;
}

- (void) stopListening {
    _eventListener.enabled = NO;
}

- (void)actuateActuationID:(SInt32)actuationID unknown1:(UInt32)unknown1 unknown2:(Float32)unknown2 unknown3:(Float32)unknown3 {
    [HTKMultitouchActuator.sharedActuator actuateActuationID:actuationID unknown1:unknown1 unknown2:unknown2 unknown3:unknown3];
}

- (void)eventListener:(HTKEventListener *)eventListener didListenEvent:(HTKEvent *)event {
    os_log_info(OS_LOG_DEFAULT, "XPC Service Event received: %d", (int)event.phase);
    [self.listener didListenEvent:event];
}
@end
NS_ASSUME_NONNULL_END
