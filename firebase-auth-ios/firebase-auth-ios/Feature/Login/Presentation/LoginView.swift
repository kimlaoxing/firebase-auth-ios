import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @EnvironmentObject var router: Router
    var body: some View {
        ZStack {
            SwiftUIColor.grayColor.ignoresSafeArea()
            
            if viewModel.isLoading {
                LoadingView()
            } else {
                ZStack {
                    SwiftUIColor.grayColor.ignoresSafeArea()
                    VStack(spacing: Padding.double) {
                        ZStack {
                            SwiftUIColor.whiteColor.ignoresSafeArea()
                            VStack(spacing: Padding.double * 2) {
                                CustomTextField(
                                    icon: "person.fill",
                                    placeHolder: "Email",
                                    useTopLeftPlaceHolder: true,
                                    text: $viewModel.email,
                                    fieldType: .regular
                                )
                                
                                CustomTextField(
                                    icon: "key",
                                    placeHolder: "Password",
                                    useTopLeftPlaceHolder: true,
                                    text: $viewModel.password,
                                    fieldType: .secure
                                )
                                
                                VStack {
                                    Color.gray
                                        .frame(height: 1)
                                    
                                    OrangeButton(title: "Login") {
                                        self.viewModel.login(with: "", password: "") { results in
                                            switch results {
                                            case true:
                                                self.router.viewState = .listView
                                            case false:
                                                break
                                            }
                                        }
                                    }
                                    .onTapGesture {
                                        self.viewModel.login(with: "", password: "") { results in
                                            switch results {
                                            case true:
                                                self.router.viewState = .listView
                                            case false:
                                                break
                                            }
                                        }
                                    }
                                    
                                    OrangeButton(title: "Register") {
                                        self.router.viewState = .registration
                                    }
                                    .onTapGesture {
                                        self.router.viewState = .registration
                                    }
                                    
                                    OrangeButton(title: "Reset Password") {
                                        self.router.viewState = .resetPassword
                                    }
                                    .onTapGesture {
                                        self.router.viewState = .resetPassword
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.isFailedLogin) {
            AlertView.alert(
                with: "Login is failed",
                message: "You have entered an invalid username or password",
                buttonText: "Cancel"
            )
        }
    }
}

