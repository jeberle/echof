#import "kit.h"

@interface XYEcho : NSObject {
  NSFileHandle* f1_;  /* incoming */
  NSFileHandle* f2_;  /* outgoing */
}
@end

@implementation XYEcho

- (void)applicationDidFinishLaunching:(NSNotification*)note {
  [self start];
  [NSApp activateIgnoringOtherApps:NO];
}

- (void)start {
  f1_ = [NSFileHandle fileHandleForReadingAtPath:@"f1"];
  f2_ = [NSFileHandle fileHandleForWritingAtPath:@"f2"];
  [f1_ retain];
  [f2_ retain];
  [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(data:) name:NSFileHandleReadCompletionNotification
      object:f1_];
  [f1_ readInBackgroundAndNotify];
}

- (void)dealloc {
  [f1_ release];
  [f2_ release];
  [super dealloc];
}

- (void)data:(NSNotification*)note {
  NSData* data = [[note userInfo] valueForKey:NSFileHandleNotificationDataItem];
  printf("data len: %lu\n", [data length]);
  if ([data length] == 0) {
    [NSApp terminate:nil];
  }
  [f1_ readInBackgroundAndNotify];
  [f2_ writeData:data];
}

@end

int main(int argc, const char *argv[]) {
  [NSApplication sharedApplication];
  [NSApp setDelegate:[XYEcho new]];
  [NSApp run];
  return 0;
}

