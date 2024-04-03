//
//  AuthViewModel.swift
//  TodoTest
//
//  Created by Hamza Douaij on 4/3/24.
//

import Foundation
import Firebase
class  AuthViewModel : ObservableObject {
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String? = nil
    
    
    func signIn(withEmail email: String, withPassword password: String, completion: @escaping (Bool) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let error = error {
                        print("Failed to sign in: \(error.localizedDescription)")
                        self.errorMessage = error.localizedDescription
                        self.isAuthenticated = false
                        completion(false)
                    } else {
                        print("Sign in successful")
                        self.isAuthenticated = true
                        completion(true)
                    }
                }
            }
        }
    func signUp(withEmail email: String, withPassword password: String, firstName: String, lastName: String, completion: @escaping (Bool   ) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to sign up: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                    self.isAuthenticated = false
                    completion(false  )
                } else {
                    print("Sign up successful")
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = "\(firstName) \(lastName)"
                    changeRequest?.commitChanges(completion: { error in
                        if let error = error {
                            print("Failed to update user profile: \(error.localizedDescription)")
                        }
                    })
                    self.isAuthenticated = true
                    completion(true )
                }
            }
        }
    }

    func signOut() {
        
    }
    func fetchUser()  {
        
    }
}
