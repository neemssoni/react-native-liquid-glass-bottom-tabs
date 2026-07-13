import SwiftUI
import UIKit
import React

// 1. Observable State to listen for React Native prop changes
class TabViewState: ObservableObject {
    @Published var tabs: [NSDictionary] = []
    @Published var selectedIndex: Int = 0
}

// 2. The actual SwiftUI View (iOS 18+ syntax)
// 2. The actual SwiftUI View (iOS 18+ syntax)
struct LiquidTabBarView: View {
    @ObservedObject var state: TabViewState
    var onTabSelected: ((Int) -> Void)?

    var body: some View {
        if #available(iOS 26.0, *) {
            TabView(selection: Binding(
                get: { state.selectedIndex },
                set: { val in
                    state.selectedIndex = val
                    onTabSelected?(val)
                }
            )) {
                ForEach(0..<state.tabs.count, id: \.self) { index in
                    let title = state.tabs[index]["title"] as? String ?? ""
                    let systemIcon = state.tabs[index]["sfSymbol"] as? String
                    let customIcon = state.tabs[index]["customIcon"] as? String
                    
                    // ✅ If a custom icon is provided, use `image:` to pull from Xcode Assets
                    if let custom = customIcon {
                        Tab(title, image: custom, value: index) {
                            Color.clear
                        }
                    } else {
                        // Otherwise fallback to Apple's built-in `systemImage:`
                        Tab(title, systemImage: systemIcon ?? "circle", value: index) {
                            Color.clear
                        }
                    }
                }
            }
            .tabBarMinimizeBehavior(.onScrollDown)
        }
    }
}

// 3. The UIView Wrapper that exposes SwiftUI to React Native
@objc class LiquidTabBarViewWrapper: UIView {
    var state = TabViewState()
    var hostingController: UIHostingController<LiquidTabBarView>?
    
    @objc var onTabPress: RCTDirectEventBlock?
    
    // ✅ Change to [Any] and call your parsing function to prevent JS crashes
    @objc var tabs: [Any] = [] {
        didSet { 
            parseAndSetTabs(from: tabs as NSArray) 
        }
    }
    
    @objc var activeIndex: Int = 0 {
        didSet { state.selectedIndex = activeIndex }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.isOpaque = false
        setupHostingController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHostingController() {
        let swiftUIView = LiquidTabBarView(state: state) { [weak self] newIndex in
            self?.onTabPress?(["index": newIndex])
        }
        
        let host = ClearHostingController(rootView: swiftUIView)
        host.view.backgroundColor = .clear
        host.view.isOpaque = false
        host.view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(host.view)
        NSLayoutConstraint.activate([
            host.view.topAnchor.constraint(equalTo: topAnchor),
            host.view.bottomAnchor.constraint(equalTo: bottomAnchor),
            host.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        self.hostingController = host
    }
  
    private func parseAndSetTabs(from rawArray: NSArray) {
        var safeTabs: [NSDictionary] = []
        
        for item in rawArray {
            if let dict = item as? NSDictionary {
                safeTabs.append(dict)
            } else if let str = item as? String {
                safeTabs.append(["title": str, "sfSymbol": "circle"])
            }
        }
        state.tabs = safeTabs
    }
}


// 1. A helper to aggressively crawl every subview
extension UIView {
    func makeCompletelyTransparent() {
        self.backgroundColor = .clear
        self.isOpaque = false
        for subview in self.subviews {
            subview.makeCompletelyTransparent()
        }
    }
}

// 2. The updated Hosting Controller
class ClearHostingController<Content: SwiftUI.View>: UIHostingController<Content> {
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Aggressively strip the background from this view and every nested child view
        self.view.makeCompletelyTransparent()
    }
}
