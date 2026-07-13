import Foundation
import React

@objc(LiquidTabBarManager)
class LiquidTabBarManager: RCTViewManager {
  
  override func view() -> UIView! {
    return LiquidTabBarViewWrapper()
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
