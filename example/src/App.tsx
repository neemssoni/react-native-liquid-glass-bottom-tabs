import * as React from 'react';
import {
  StyleSheet,
  View,
  Text,
  TouchableOpacity,
  DynamicColorIOS,
  useColorScheme,
} from 'react-native';
import {
  NavigationContainer,
  createNavigationContainerRef,
  CommonActions,
} from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

// Import your newly created package!
import LiquidTabBar from 'react-native-liquid-glass-bottom-tabs';

export type RootStackParamList = {
  Home: undefined;
  Profile: undefined;
};

// 1. Create the global navigation ref
export const navigationRef = createNavigationContainerRef<RootStackParamList>();

// --- Demo Screens ---
function HomeScreen() {
  const bg = { backgroundColor: '#FF3B30' };
  return (
    <View style={[styles.screen, bg]}>
      <Text style={styles.title}>Home Screen</Text>
      <TouchableOpacity
        style={styles.button}
        onPress={() =>
          navigationRef.isReady() && navigationRef.navigate('Profile' as never)
        }
      >
        <Text style={styles.buttonText}>Go to Profile</Text>
      </TouchableOpacity>
    </View>
  );
}

function ProfileScreen() {
  const bg = { backgroundColor: '#FF9500' };
  return (
    <View style={[styles.screen, bg]}>
      <Text style={styles.title}>Profile Screen</Text>
    </View>
  );
}

// --- Stack Setup ---
const Stack = createStackNavigator();

export default function App() {
  const [activeRouteIndex, setActiveRouteIndex] = React.useState(0);

  // 2. Handle the tab press from the native Swift bridge
  const handleTabPress = (e: any) => {
    const newIndex = e.nativeEvent.index;

    if (navigationRef.isReady()) {
      if (newIndex === 1) {
        navigationRef.dispatch(CommonActions.navigate({ name: 'Profile' }));
      } else {
        navigationRef.dispatch(CommonActions.navigate({ name: 'Home' }));
      }
    }
  };

  const myTabs = [
    { title: 'Home', sfSymbol: 'house.fill' },
    { title: 'Profile', sfSymbol: 'person.fill' },
  ];

  // Define dynamic colors that adapt to the system theme
  const activeTintColor = DynamicColorIOS({
    light: '#1C3FCA', // Blue for light mode
    dark: '#1C3FCA', // Lighter blue for dark mode
  });

  const inactiveTintColor = DynamicColorIOS({
    light: '#4B5563',
    dark: '#4B5563',
  });

  const colorScheme = useColorScheme(); // 'light' or 'dark'
  return (
    <View style={styles.container}>
      {/* 3. Standard Navigation Container */}
      <NavigationContainer
        ref={navigationRef}
        onStateChange={() => {
          // Keep the native pill in sync if the user navigates via buttons
          if (navigationRef.isReady()) {
            const currentRouteName = navigationRef.getCurrentRoute()?.name;
            setActiveRouteIndex(currentRouteName === 'Profile' ? 1 : 0);
          }
        }}
      >
        <Stack.Navigator screenOptions={{ headerShown: false }}>
          <Stack.Screen name="Home" component={HomeScreen} />
          <Stack.Screen name="Profile" component={ProfileScreen} />
        </Stack.Navigator>
      </NavigationContainer>

      {/* 4. The Liquid Glass Overlay */}
      <View style={StyleSheet.absoluteFill} pointerEvents="box-none">
        <LiquidTabBar
          tabs={myTabs}
          activeIndex={activeRouteIndex}
          onTabPress={handleTabPress}
          activeTintColor={activeTintColor}
          inactiveTintColor={inactiveTintColor}
          theme={colorScheme}
          // CHANGE THIS: Remove StyleSheet.absoluteFill
          // Use a fixed height and position it at the bottom
          style={styles.liquidTabBar}
        />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'black',
  },
  screen: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  title: {
    color: 'white',
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  button: {
    backgroundColor: 'rgba(255,255,255,0.2)',
    paddingHorizontal: 20,
    paddingVertical: 12,
    borderRadius: 10,
  },
  buttonText: {
    color: 'white',
    fontWeight: '600',
  },
  liquidTabBar: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,

    height: 64, // Adjust this value to match your design height
  },
});
