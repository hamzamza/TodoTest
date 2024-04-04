 
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
    var body: some View {
            VStack{
            
                      switch navigationViewModel.currentScreen {
                        case .login:
                            LoginView()
                        case .signUp:
                            SignUpView()
                        case .tasklist:
                            TaskListView()
                        case .loading:
                            LoadingView()
                        default:
                            EmptyView()
                        }
                }
            .onAppear {
                    authViewModel.fetchAuthState { isAuthenticated in
                        DispatchQueue.main.async {
                            if navigationViewModel.currentScreen == .loading {
                            navigationViewModel.navigateBasedOnAuthState(isAuthenticated: isAuthenticated)
                            }
                        }
                    }
                }
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 
 
 
