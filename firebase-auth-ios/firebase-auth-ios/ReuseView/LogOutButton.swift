import SwiftUI

struct LogOutButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Text(title)
                    .font(FontSize.headline.font(weight: .semibold))
                
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
            }
        })
        .padding()
//        .frame(maxWidth: .infinity)
        .foregroundColor(SwiftUIColor.textWhite)
        .background(.red)
        .cornerRadius(10)
    }
}
