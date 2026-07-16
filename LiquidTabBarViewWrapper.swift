import UIKit
import React

@objc class LiquidTabBarViewWrapper: UIView {
    let tabController = LiquidTabBarController()
  
    @objc var tabs: NSArray = [] {
        didSet {
            // Re-setup the tabs whenever the React Native prop changes
            tabController.setupTabs(with: tabs as! [NSDictionary], onSelect: { [weak self] index in
                self?.onTabPress?(["index": index])
            })
        }
    }
  
    @objc var activeIndex: Int = 0 {
        didSet { tabController.selectedIndex = activeIndex }
    }
    
    @objc var onTabPress: RCTDirectEventBlock?
      
      
    @objc var activeTintColor: UIColor = .blue {
        didSet {
            tabController.tabBar.tintColor = activeTintColor
        }
    }
    
    @objc var inactiveTintColor: UIColor = .gray {
        didSet {
            tabController.tabBar.unselectedItemTintColor = inactiveTintColor
        }
    }
  
    @objc var theme: String = "light" {
        didSet {
            // Handle your theme logic here (e.g., UIUserInterfaceStyle)
            self.overrideUserInterfaceStyle = theme == "dark" ? .dark : .light
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        // Add the controller's view
        addSubview(tabController.view)
      
        tabController.onTabSelected = { [weak self] index in
            self?.onTabPress?(["index": index])
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tabController.view.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
