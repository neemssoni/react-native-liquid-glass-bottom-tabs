Markdown
# react-native-liquid-glass-bottom-tabs

A high-performance, native SwiftUI-based tab bar component for React Native. Featuring the "Liquid Glass" floating effect, native iOS 18+ TabView integration, and full support for custom SF Symbols.

## Features

- **Native SwiftUI:** Built with a native `UIHostingController` for butter-smooth animations.
- **Floating Design:** Designed for the modern Global Overlay Pattern.
- **Customizable:** Supports both Apple's system symbols and your own custom SF Symbols.
- **TypeScript Ready:** Full type definitions included.

## Installation

```sh
npm install react-native-liquid-glass-bottom-tabs
Usage
TypeScript
import { LiquidTabBar } from 'react-native-liquid-glass-bottom-tabs';

// ...

const myTabs = [
  { title: 'Home', sfSymbol: 'house.fill' },
  { title: 'Profile', customIcon: 'my_custom_asset' }
];

// Inside your main App component
<LiquidTabBar
  tabs={myTabs}
  activeIndex={activeIndex}
  onTabPress={(e) => setActiveIndex(e.nativeEvent.index)}
/>
Requirements
iOS 18.0+

React Native 0.70+

Xcode 16+ (for iOS 18 SDK support)

Contributing
Development workflow

Sending a pull request

Code of conduct

License
MIT

Made with create-react-native-library