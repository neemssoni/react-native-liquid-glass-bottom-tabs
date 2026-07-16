import Foundation
import React

@objc(LiquidTabBarViewManager)
class LiquidTabBarViewManager: RCTViewManager {
  
  override func view() -> UIView! {
    return LiquidTabBarViewWrapper()
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
