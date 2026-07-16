@objc class LiquidTabBarViewWrapper: UIView {
    let tabController = LiquidTabBarController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        // Add the controller's view
        addSubview(tabController.view)
        
        // IMPORTANT: The tab bar must be added to the view hierarchy
        // OR the appearance settings won't apply correctly.
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Ensure the controller matches the wrapper's size
        tabController.view.frame = self.bounds
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
