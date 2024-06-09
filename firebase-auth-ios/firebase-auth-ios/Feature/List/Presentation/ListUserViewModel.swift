import SwiftUI

final class ListUserViewModel: ObservableObject {
    @Published var userList: [User]?
    @Published var isLogout: Bool = false
    private let firebaseInstance: FirebaseInstanceProtocol
    
    init(firebaseInstance: FirebaseInstanceProtocol) {
        self.firebaseInstance = firebaseInstance
    }
    
    func getList() {
        self.firebaseInstance.fetchUsersFromFirestore { results in
            switch results {
            case .success(let success):
                self.userList = success
            case .failure(let failure):
                break
            }
        }
    }
    
    func logout() {
        self.firebaseInstance.logoutUser { results in
            switch results {
            case .success(let success):
                self.isLogout = true
            case .failure(let failure):
                self.isLogout = false
            }
        }
    }
    
    func setupAuthStateListener(with id: String) {
        firebaseInstance.setupAuthStateListener(with: id) { getListAgain in
            if getListAgain {
                self.getList()
            }
        }
    }
}
