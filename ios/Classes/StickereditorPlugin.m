#import "StickereditorPlugin.h"
#if __has_include(<stickereditor/stickereditor-Swift.h>)
#import <stickereditor/stickereditor-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "stickereditor-Swift.h"
#endif

@implementation StickereditorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftStickereditorPlugin registerWithRegistrar:registrar];
}
@end
