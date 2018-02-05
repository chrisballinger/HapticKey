//
//  EventTapXPCListener.h
//  EventTap
//
//  Created by Chris Ballinger on 2/4/18.
//  Copyright © 2018 Yoshimasa Niwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTKEventListener.h"
#import "HTKEvent.h"

NS_ASSUME_NONNULL_BEGIN

/** "at.niw.EventTapXPCService" */
FOUNDATION_EXPORT NSString *const EventTapXPCServiceName;

@protocol EventTapXPCListener <NSObject>
@required
- (void) didListenEvent:(HTKEvent *)event;
@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
@protocol EventTapXPCServiceProtocol <NSObject>
@required

- (void) setupGestureListener;
- (void) setupFunctionKeyListener;

- (void) startListening;
- (void) stopListening;

- (void) teardown;

- (void)actuateActuationID:(SInt32)actuationID unknown1:(UInt32)unknown1 unknown2:(Float32)unknown2 unknown3:(Float32)unknown3;

@end
NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN
@interface HTKEventXPCListener : HTKEventListener <EventTapXPCListener, EventTapXPCServiceProtocol>

@end
NS_ASSUME_NONNULL_END
