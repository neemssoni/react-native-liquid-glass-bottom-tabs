import SwiftUI
import UIKit
import React

// 1. Observable State to listen for React Native prop changes
class TabViewState: ObservableObject {
    @Published var tabs: [NSDictionary] = []
    @Published var selectedIndex: Int = 0
    @Published var activeTintColor: UIColor = .blue
    @Published var inactiveTintColor: UIColor = .gray
    @Published var theme: String = "light"
}

// 2. The actual SwiftUI View (iOS 18+ syntax)
struct LiquidTabBarView: View {
    @ObservedObject var state: TabViewState
    var onTabSelected: ((Int) -> Void)?

    var body: some View {
        // Fallback check: The new Tab API requires iOS 26
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
                            
                            if let custom = customIcon {
                                Tab(title, image: custom, value: index) { Color.clear }
                            } else {
                                Tab(title, systemImage: systemIcon ?? "circle", value: index) { Color.clear }
                            }
                        }
                    }
                    // Apply the theme and tint colors
                    .tabBarMinimizeBehavior(.onScrollDown)
                    .tint(Color(state.activeTintColor)) // Active tint
                    .preferredColorScheme(state.theme == "dark" ? .dark : .light) // Theme
              }
    }
}

// 3. The UIView Wrapper that exposes SwiftUI to React Native
@objc class LiquidTabBarViewWrapper: UIView {
    var state = TabViewState()
    var hostingController: UIHostingController<LiquidTabBarView>?
    
    @objc var onTabPress: RCTDirectEventBlock?
    
    @objc var tabs: [Any] = [] {
        didSet { 
            parseAndSetTabs(from: tabs as NSArray) 
        }
    }
    
    @objc var activeIndex: Int = 0 {
        didSet { state.selectedIndex = activeIndex }
    }

    @objc var activeTintColor: UIColor = .blue {
        didSet { state.activeTintColor = activeTintColor }
    }
    
    @objc var inactiveTintColor: UIColor = .gray {
        didSet { state.inactiveTintColor = inactiveTintColor }
    }
    
    @objc var theme: String = "light" {
        didSet { state.theme = theme }
    }
    
  override init(frame: CGRect) {
          super.init(frame: frame)
          // 1. Force this UIView wrapper to be invisible
          self.backgroundColor = .clear
          self.isOpaque = false //
          // 2. Setup the SwiftUI view
          setupHostingController()
      }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHostingController() {
      let swiftUIView = LiquidTabBarView(state: state) { [weak self] newIndex in
                  self?.onTabPress?(["index": newIndex])
              }
              
              // 2. Swap UIHostingController for our new ClearHostingController
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
                  // If it's correctly passed as an Object {title: "...", sfSymbol: "..."}
                  safeTabs.append(dict)
              } else if let str = item as? String {
                  // If JS accidentally passes a string array ["Home", "Settings"]
                  // We create a fallback dictionary so it doesn't crash!
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
