import SwiftUI

struct OrangeButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(FontSize.title.font(weight: .semibold))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .foregroundColor(SwiftUIColor.textWhite)
        .background(SwiftUIColor.orangeColor)
        .cornerRadius(10)
    }
}

struct GenericButton: View {
    var title: String
    var foregroundColor: Color
    var backgroundColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
                Text(title)
                    .font(FontSize.headline.font(weight: .semibold))
                    .multilineTextAlignment(.center)
        })
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(self.foregroundColor)
        .background(self.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(SwiftUIColor.orangeColor, lineWidth: 2)
        )
    }
}
