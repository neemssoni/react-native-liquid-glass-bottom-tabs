import Foundation
import React

@objc(LiquidTabBarManager)
class LiquidTabBarManager: RCTViewManager {
  
  override func view() -> UIView! {
    return LiquidTabBarViewWrapper()
  }
  
  @objc var activeTintColor: UIColor {
          set { /* Not strictly needed if using @objc in the View directly */ }
          get { return .blue }
      }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
