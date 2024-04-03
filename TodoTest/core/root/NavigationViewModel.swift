// I've creted this navigation view model because I can't use navigation view to navigate programmaticly to other screen

import Foundation
class NavigationViewModel: ObservableObject {
    enum Screen {
        case login
        case signIn
        case home
        case details
    }
    
    @Published var currentScreen: Screen = .login
    private var screenStack: [Screen] = []
    
    func navigateTo(screen: Screen) {
        
        screenStack.append(currentScreen)
        currentScreen = screen
    }
    
    func resetAndNavigateTo(screen: Screen) {
        screenStack = [] // Reset the navigation stack
        currentScreen = screen // Navigate to the specified screen
    }
 
    func navigateBack() {
        guard let previousScreen = screenStack.popLast() else { return }
        currentScreen = previousScreen
    }
}
