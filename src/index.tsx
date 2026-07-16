import { requireNativeComponent } from 'react-native';
import type {
  ViewProps,
  NativeSyntheticEvent,
  ColorValue,
  ColorSchemeName,
} from 'react-native';

export interface TabItem {
  title: string;
  sfSymbol?: string; // Used for built-in Apple icons
  customIcon?: string; // Used for custom SVGs in the Xcode Asset Catalog
}

interface LiquidTabBarProps extends ViewProps {
  tabs: TabItem[];
  activeIndex: number;
  onTabPress?: (event: NativeSyntheticEvent<{ index: number }>) => void;
  // Use ColorValue to support DynamicColorIOS
  activeTintColor: ColorValue;
  inactiveTintColor: ColorValue;
  theme: ColorSchemeName | null | undefined;
}

// Interacts with the registered native module string name
const NativeLiquidTabBar =
  requireNativeComponent<LiquidTabBarProps>('LiquidTabBarView');

export default function LiquidTabBar(props: LiquidTabBarProps) {
  return <NativeLiquidTabBar {...props} />;
}
