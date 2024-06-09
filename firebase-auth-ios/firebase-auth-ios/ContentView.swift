import SwiftUI

struct ContentView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        rootView()
    }
    
    public func rootView() -> some View {
        return ZStack {
            SwiftUIColor.whiteColor.ignoresSafeArea()
            switch router.viewState {
            case .login:
                self.router.loginView()
            case .registration:
                self.router.registrationView()
            case .listView:
                self.router.listView()
            case .resetPassword:
                self.router.resetPasswordView()
            }
        }
    }
}
