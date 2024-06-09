import SwiftUI

struct ListUserView: View {
    @ObservedObject var viewModel: ListUserViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        self.userListSection()
            .onAppear {
                self.viewModel.getList()
            }
    }
    
    private func userListSection() -> some View {
        ZStack {
            SwiftUIColor.whiteColor.ignoresSafeArea()
            ScrollView() {
                VStack(spacing: Padding.double) {
                    HStack {
                        Text("User List")
                            .font(FontSize.title.font(weight: .semibold))
                            .foregroundColor(SwiftUIColor.textBlack)
                        Spacer()
                        LogOutButton(title: "Logout") {
                            self.viewModel.logout()
                        }
                        .onTapGesture {
                            self.viewModel.logout()
                        }
                    }
                    
                    Rectangle()
                        .foregroundColor(SwiftUIColor.grayColor)
                        .frame(height: 2)
                    
                    if self.viewModel.userList?.count != 0 {
                        usersTableView()
                    } else {
                        Text("user is nil")
                            .foregroundStyle(SwiftUIColor.textBlack)
                            .font(FontSize.subheadline.font(weight: .regular))
                            .multilineTextAlignment(.center)
                    }
                    
                    Rectangle()
                        .foregroundColor(SwiftUIColor.grayColor)
                        .frame(height: 2)
                }
                .padding()
            }
          
        }
        .onChange(of: self.viewModel.isLogout) { oldValue, newValue in
            if newValue == true {
                self.router.viewState = .login
            }
        }
    }
    
    private func usersTableView() -> some View {
        LazyVStack {
            ForEach(self.viewModel.userList ?? [], id: \.id) { user in
                UserCell(viewModel: self.viewModel, user: user)
            }
        }
    }
}
