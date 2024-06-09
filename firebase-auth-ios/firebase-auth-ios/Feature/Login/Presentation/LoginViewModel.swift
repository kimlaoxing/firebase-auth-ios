import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var email: String = "kimlaoxing@gmail.com"
    @Published var password: String = "Jksadqei1-"
    @Published var isFailedLogin: Bool = false
    private let fireBaseInstance: FirebaseInstanceProtocol
    
    init(fireBaseInstance: FirebaseInstanceProtocol) {
        
        self.fireBaseInstance = fireBaseInstance
    }
    
    func login(with email: String, password: String, _ completion: @escaping((Bool) -> Void)) {
        self.fireBaseInstance.loginUser(email: self.email, password: self.password) { results in
            switch results {
            case .success(let success):
                completion(true)
            case .failure(let failure):
                completion(false)
            }
        }
    }
}
