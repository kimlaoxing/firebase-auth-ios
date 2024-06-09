import SwiftUI

struct UserCell: View {
    
    @ObservedObject var viewModel: ListUserViewModel
    
    var user: User?
    
    var body: some View {
        if let user = self.user {
            bodyView(with: user)
                .padding((.init(top: Padding.reguler, leading: 0, bottom: Padding.reguler, trailing: 0)))
                .onAppear {
                    self.viewModel.setupAuthStateListener(with: user.id)
                }
        }
    }
}

extension UserCell {
    func bodyView(with user: User) -> some View {
        ZStack {
            SwiftUIColor.whiteColor.ignoresSafeArea()
            HStack(alignment: .top, spacing: Padding.double) {
                VStack(alignment: .leading, spacing: Padding.double) {
                    HStack {
                        textDetail(with: "Name")
                        Spacer()
                        textDetail(with: user.name)
                    }
                    
                    HStack {
                        textDetail(with: "Email")
                        Spacer()
                        textDetail(with: user.email)
                    }
                    
                    HStack {
                        textDetail(with: "is verifiy")
                        Spacer()
                        textDetail(with: "\(user.isEmailVerified)")
                    }
                }
                Spacer()
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(SwiftUIColor.grayColor, lineWidth: 2)
        )
        
    }
    
    func textDetail(with detail: String, color: Color? = nil) -> some View {
        Text(detail)
            .font(FontSize.body.font(weight: .regular))
            .foregroundStyle(color ?? SwiftUIColor.textBlack)
            .multilineTextAlignment(.leading)
    }
    
    func textTitle(with title: String) -> some View {
        Text(title)
            .font(FontSize.headline.font(weight: .medium))
            .foregroundStyle(SwiftUIColor.textGray)
            .multilineTextAlignment(.leading)
    }
}
