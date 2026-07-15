#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LiquidTabBarManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(tabs, NSArray)
RCT_EXPORT_VIEW_PROPERTY(activeIndex, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(onTabPress, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(activeTintColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(inactiveTintColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(theme, NSString)

@end
