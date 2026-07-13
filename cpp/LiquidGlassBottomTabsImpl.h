#pragma once

#include <LiquidGlassBottomTabsSpecJSI.h>

#include <memory>

namespace facebook::react {

class LiquidGlassBottomTabsImpl
  : public NativeLiquidGlassBottomTabsCxxSpec<LiquidGlassBottomTabsImpl> {
public:
  LiquidGlassBottomTabsImpl(std::shared_ptr<CallInvoker> jsInvoker);

  double multiply(jsi::Runtime& rt, double a, double b);
};

}
