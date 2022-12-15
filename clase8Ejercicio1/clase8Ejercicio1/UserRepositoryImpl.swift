//
//  UserRepository.swift
//  clase8Ejercicio1
//
//  Created by Mac on 15/12/22.
//

class UserRepositoryImpl: UserRepository {
    
    private struct Users {
        static let userDB = [User(name: "Juan", lastName: "Sebastian", email: "hola@test.com", photo: "JuanPhoto"),User(name: "Claudia", lastName: "Isabel", email: "claudia@", photo: "ClaudiaPhoto")]
        static let defaultUser = User(name: "", lastName: "", email: "", photo: "interrogante")
    }
    
    func findUser(_ email: String) -> User {
        return Users.userDB.first { user in
            user.email == email
        } ?? Users.defaultUser
    }
}
