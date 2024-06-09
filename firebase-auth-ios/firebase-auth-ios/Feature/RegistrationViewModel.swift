import SwiftUI

final class RegistrationViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var isFailedRegistration: Bool = false
    @Published var isSuccessRegistration: Bool = false
    
    private let fireBaseInstance: FirebaseInstanceProtocol
    
    init(fireBaseInstance: FirebaseInstanceProtocol) {
        self.fireBaseInstance = fireBaseInstance
    }
        
    func registration() {
        self.fireBaseInstance.registerUser(email: self.email, password: self.password) { results in
            switch results {
            case .success(_):
                self.fireBaseInstance.sendEmailVerification { error in
                    if error != nil {
                        self.isSuccessRegistration = false
                        self.isFailedRegistration = true
                    } else {
                        self.isFailedRegistration = false
                        self.isSuccessRegistration = true
                        self.fireBaseInstance.addDataToFirestore(with: self.email, password: self.password, name: self.name)
                    }
                }
            case .failure(let failure):
                self.isFailedRegistration = true
                self.isSuccessRegistration = false
            }
        }
    }
}
