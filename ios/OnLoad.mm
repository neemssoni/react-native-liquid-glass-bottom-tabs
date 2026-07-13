#import <Foundation/Foundation.h>
#import "LiquidGlassBottomTabsImpl.h"
#import <ReactCommon/CxxTurboModuleUtils.h>

@interface LiquidGlassBottomTabsOnLoad : NSObject
@end

@implementation LiquidGlassBottomTabsOnLoad

using namespace facebook::react;

+ (void)load
{
  registerCxxModuleToGlobalModuleMap(
    std::string(LiquidGlassBottomTabsImpl::kModuleName),
    [](std::shared_ptr<CallInvoker> jsInvoker) {
      return std::make_shared<LiquidGlassBottomTabsImpl>(jsInvoker);
    }
  );
}

@end
