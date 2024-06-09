import SwiftUI

struct AlertView {
    static func alert(
        with title: String,
        message: String,
        buttonText: String
    ) -> Alert {
        Alert(
            title: Text(title),
            message: Text(message),
            dismissButton: .default(Text(buttonText))
        )
    }
}
