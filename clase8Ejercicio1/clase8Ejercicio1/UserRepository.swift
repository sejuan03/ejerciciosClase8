//
//  UserRepository.swift
//  clase8Ejercicio1
//
//  Created by Mac on 15/12/22.
//

protocol UserRepository {
    func findUser(_ email: String) -> User
}
