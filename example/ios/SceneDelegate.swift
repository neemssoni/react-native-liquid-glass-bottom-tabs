import UIKit

@objc(SceneDelegate)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
      guard let windowScene = scene as? UIWindowScene else { return }
      
      // 1. Grab the exact window that the React Native Factory just finished building
      if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
         let reactWindow = appDelegate.window {
          
          // 2. Attach iOS 27's WindowScene directly to React Native's window
          reactWindow.windowScene = windowScene
          self.window = reactWindow
          
          // 3. Force it to render
          self.window?.makeKeyAndVisible()
          
      } else {
          // Fallback just in case the AppDelegate wasn't ready
          let fallbackWindow = UIWindow(windowScene: windowScene)
          fallbackWindow.backgroundColor = .white
          self.window = fallbackWindow
          self.window?.makeKeyAndVisible()
      }
    }
}
