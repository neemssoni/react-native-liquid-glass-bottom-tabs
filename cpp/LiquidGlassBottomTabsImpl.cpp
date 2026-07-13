#include "LiquidGlassBottomTabsImpl.h"

namespace facebook::react {

LiquidGlassBottomTabsImpl::LiquidGlassBottomTabsImpl(
  std::shared_ptr<CallInvoker> jsInvoker
)
  : NativeLiquidGlassBottomTabsCxxSpec(std::move(jsInvoker)) {}

double LiquidGlassBottomTabsImpl::multiply(
  jsi::Runtime& rt,
  double a,
  double b
) {
  return a * b;
}

}
