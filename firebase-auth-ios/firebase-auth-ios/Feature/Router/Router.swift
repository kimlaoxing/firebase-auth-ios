import SwiftUI

final class Router: ObservableObject {
    @Published var viewState: ViewState = .login
    
    func loginView() -> some View {
        let fireBaseInstance = FirebaseInstance()
        let viewModel = LoginViewModel(fireBaseInstance: fireBaseInstance)
        let view = LoginView(viewModel: viewModel)
            .environmentObject(self)
        return view
    }
    
    func registrationView() -> some View {
        let fireBaseInstance = FirebaseInstance()
        let viewModel = RegistrationViewModel(fireBaseInstance: fireBaseInstance)
        let view = RegistrationView(viewModel: viewModel)
            .environmentObject(self)
        return view
    }
    
    func listView() -> some View {
        let fireBaseInstance = FirebaseInstance()
        let viewModel = ListUserViewModel(firebaseInstance: fireBaseInstance)
        let loginViewModel = LoginViewModel(fireBaseInstance: fireBaseInstance)
        let view = ListUserView(viewModel: viewModel, loginViewModel: loginViewModel)
            .environmentObject(self)
        return view
    }
    
    func resetPasswordView() -> some View {
        let fireBaseInstance = FirebaseInstance()
        let viewModel = ResetPasswordViewModel(fireBaseInstance: fireBaseInstance)
        let view = ResetPasswordView(viewModel: viewModel)
        return view
    }
}

enum ViewState {
    case login
    case registration
    case listView
    case resetPassword
}
