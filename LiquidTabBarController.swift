//
//  LiquidTabBarController.swift
//  Pods
//
//  Created by Neelam Soni on 15/07/26.
//
//
//  LiquidTabBarController.swift
//  LiquidGlassTabs
//
//  Created by Neelam Soni on 15/07/26.
//

import UIKit

class LiquidTabBarController: UITabBarController {
  
    var onTabSelected: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Configure the Liquid Glass Appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        // This is the "secret sauce" for the iOS 26 Liquid effect
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        
        // 2. Hide the tab bar content container
        // We set the controller to only care about the bar
        self.view.backgroundColor = .clear
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item) {
            onTabSelected?(index) // This sends the event back to the Wrapper
        }
    }
  
    func setupTabs(with data: [NSDictionary], onSelect: @escaping (Int) -> Void) {
        var vcs: [UIViewController] = []
        
        for (index, tabData) in data.enumerated() {
            let vc = DummyViewController()
            let title = tabData["title"] as? String ?? ""
            let symbol = tabData["sfSymbol"] as? String ?? "circle"
            let customIcon = tabData["customIcon"] as? String
            
            var tabImage: UIImage?
          
            if let customName = customIcon, let customImage = UIImage(named: customName) {
                tabImage = customImage
            } else {
                // 2. Fallback to SF Symbol
                tabImage = UIImage(systemName: symbol)
            }
          
            vc.tabBarItem = UITabBarItem(
                title: title,
                image: tabImage,
                tag: index
            )
            vcs.append(vc)
        }
        
        self.viewControllers = vcs
        self.delegate = self
    }
}

extension LiquidTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
      if (tabBarController.viewControllers?.firstIndex(of: viewController)) != nil {
            // Callback to React Native
            // onSelect?(index)
        }
    }
}
