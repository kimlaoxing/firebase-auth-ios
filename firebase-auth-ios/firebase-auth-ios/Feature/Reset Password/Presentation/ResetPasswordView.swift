import SwiftUI

struct ResetPasswordView: View {
    @ObservedObject var viewModel: ResetPasswordViewModel
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
                                                                
                                VStack {
                                    Color.gray
                                        .frame(height: 1)
                                    HStack {
                                        GenericButton(title: "Back", foregroundColor: SwiftUIColor.orangeColor, backgroundColor: SwiftUIColor.whiteColor) {
                                            self.router.viewState = .login
                                        }.onTapGesture {
                                            self.router.viewState = .login
                                        }
                                        
                                        GenericButton(title: "Accept", foregroundColor: SwiftUIColor.whiteColor, backgroundColor: SwiftUIColor.orangeColor) {
                                            self.viewModel.resetPassword()
                                        }
                                        .onTapGesture {
                                            self.viewModel.resetPassword()
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.isFailedResetPassword) {
            AlertView.alert(
                with: "Reset Password is Failed",
                message: "Please type your email correctly",
                buttonText: "Cancel"
            )
        }
        .alert(isPresented: $viewModel.isSuccessReesetPassword) {
            Alert(
                title: Text("Reset Password  Success"),
                message: Text("You have successfully Reset Password."),
                dismissButton: .default(Text("OK")) {
                    self.router.viewState = .login
                }
            )
        }
    }
}

