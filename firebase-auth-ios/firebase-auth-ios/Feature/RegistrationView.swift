import SwiftUI

struct RegistrationView: View {
    @ObservedObject var viewModel: RegistrationViewModel
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
                                    icon: "person.fill",
                                    placeHolder: "Password",
                                    useTopLeftPlaceHolder: true,
                                    text: $viewModel.password,
                                    fieldType: .regular
                                )
                                
                                CustomTextField(
                                    icon: "person.fill",
                                    placeHolder: "Name",
                                    useTopLeftPlaceHolder: true,
                                    text: $viewModel.name,
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
                                            self.viewModel.registration()
                                        }
                                        .onTapGesture {
                                            self.viewModel.registration()
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
        .alert(isPresented: $viewModel.isFailedRegistration) {
            AlertView.alert(
                with: "Registration is Failed",
                message: "Try another email",
                buttonText: "Cancel"
            )
        }
        .alert(isPresented: $viewModel.isSuccessRegistration) {
            Alert(
                title: Text("Registration Success"),
                message: Text("You have successfully registered."),
                dismissButton: .default(Text("OK")) {
                    self.router.viewState = .login
                }
            )
        }
    }
}

