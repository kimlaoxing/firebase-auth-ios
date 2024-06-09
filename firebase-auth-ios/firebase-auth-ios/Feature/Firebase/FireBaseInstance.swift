import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol FirebaseInstanceProtocol {
    func registerUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func sendEmailVerification(completion: @escaping (Error?) -> Void)
    func loginUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func addDataToFirestore(with email: String, password: String, name: String)
    func fetchUsersFromFirestore(completion: @escaping (Result<[User], Error>) -> Void)
    func setupAuthStateListener(with id: String, _ completion: @escaping((Bool) -> Void))
    func logoutUser(completion: @escaping (Result<Void, Error>) -> Void)
    func updateUserVerificationStatus(id: String, isVerified: Bool, completion: @escaping (Error?) -> Void)
    func resetPassword(for email: String, completion: @escaping (Bool) -> Void)
}

final class FirebaseInstance: FirebaseInstanceProtocol {
    
    func resetPassword(for email: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func logoutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let signOutError as NSError {
            completion(.failure(signOutError))
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                self.sendEmailVerification { error in
                    print("error is sendEmailVerification \(error)")
                }
                completion(.success(authResult))
            }
        }
    }
    
    func sendEmailVerification(completion: @escaping (Error?) -> Void) {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            completion(error)
        })
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
    
    func addDataToFirestore(with email: String, password: String, name: String) {
        let db = Firestore.firestore()
        let user = User(
            id: UUID().uuidString,
            email: email,
            name: name,
            isEmailVerified: false
        )
        
        do {
            try db.collection("users").document(user.id).setData(from: user) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added successfully!")
                }
            }
        } catch let error {
            print("Error encoding user data: \(error.localizedDescription)")
        }
    }
    
    func fetchUsersFromFirestore(completion: @escaping (Result<[User], Error>) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                var users: [User] = []
                for document in querySnapshot!.documents {
                    do {
                        let user = try document.data(as: User.self)
                        users.append(user)
                    } catch let error {
                        completion(.failure(error))
                        return
                    }
                }
                completion(.success(users))
            }
        }
    }
    
    func setupAuthStateListener(with id: String, _ completion: @escaping((Bool) -> Void)) {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                user.reload { error in
                    if let error = error {
                        print("Error reloading user: \(error.localizedDescription)")
                    } else {
                        if user.isEmailVerified {
                            self.updateUserVerificationStatus(id: id, isVerified: true) { error in
                                if error != nil {
                                    completion(true)
                                }
                            }
                        } else {
                            self.updateUserVerificationStatus(id: id, isVerified: false) { error in
                                completion(false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateUserVerificationStatus(id: String, isVerified: Bool, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(id)
        
        userRef.updateData(["isEmailVerified": isVerified]) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
}
