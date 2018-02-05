//
//  EventTapXPCManager.m
//  EventTap
//
//  Created by Chris Ballinger on 2/4/18.
//  Copyright © 2018 Yoshimasa Niwa. All rights reserved.
//

#import "EventTapXPCManager.h"
#import "HTKEventListener.h"

@import os.log;

/** "at.niw.EventTapXPCService" */
NSString *const EventTapXPCServiceName = @"at.niw.EventTapXPCService";

NS_ASSUME_NONNULL_BEGIN
@interface HTKEventXPCListener()
@property (nonatomic, strong, readonly, nullable) NSXPCConnection *connection;
@property (nonatomic, strong, readonly, nullable) id<EventTapXPCServiceProtocol> service;
@end

@implementation HTKEventXPCListener
@synthesize enabled = _enabled;

- (void) dealloc {
    [self teardown];
}

- (instancetype) init {
    if (self = [super init]) {
        [self setupConnection];
    }
    return self;
}

- (void)setupConnection {
    if (_connection) {
        return;
    }
    _connection = [[NSXPCConnection alloc] initWithServiceName:EventTapXPCServiceName];
    self.connection.exportedObject = self;
    self.connection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(EventTapXPCListener)];
    self.connection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(EventTapXPCServiceProtocol)];
    [self.connection resume];
    _service = [self.connection remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        os_log_error(OS_LOG_DEFAULT, "XPC Listener Error: %@", error);
    }];
}

- (void) teardown {
    if (self.service) {
        [self.service teardown];
    }
    if (self.connection) {
        [self.connection invalidate];
    }
    _connection = nil;
    _service = nil;
}

- (void)didListenEvent:(HTKEvent *)event {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate eventListener:self didListenEvent:event];
    });
}

- (void) setEnabled:(BOOL)enabled {
    _enabled = enabled;
    if (enabled) {
        [self startListening];
    } else {
        [self stopListening];
    }
}

- (BOOL) isEnabled {
    return _enabled;
}

- (void) setupGestureListener {
    [self.service setupGestureListener];
}

- (void) setupFunctionKeyListener {
    [self.service setupFunctionKeyListener];
}

- (void) startListening {
    [self.service startListening];
}

- (void) stopListening {
    [self.service stopListening];
}

@end
NS_ASSUME_NONNULL_END
