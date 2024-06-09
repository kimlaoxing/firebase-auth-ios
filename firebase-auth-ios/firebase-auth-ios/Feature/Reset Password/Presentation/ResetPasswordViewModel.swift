import SwiftUI

final class ResetPasswordViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var email: String = ""
    @Published var isFailedResetPassword: Bool = false
    @Published var isSuccessReesetPassword: Bool = false
    
    private let fireBaseInstance: FirebaseInstanceProtocol
    
    init(fireBaseInstance: FirebaseInstanceProtocol) {
        self.fireBaseInstance = fireBaseInstance
    }
        
    func resetPassword() {
        self.fireBaseInstance.resetPassword(for: self.email) { isSuccess in
            if isSuccess {
                self.isSuccessReesetPassword = true
                self.isFailedResetPassword = false
            } else {
                self.isSuccessReesetPassword = false
                self.isFailedResetPassword = true
            }
        }
    }
}
