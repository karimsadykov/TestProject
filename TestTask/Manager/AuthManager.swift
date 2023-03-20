//
//  AuthManager.swift
//  TestTask
//
//  Created by Карим Садыков on 10.03.2023.
//

import UIKit

//final class AuthManager {
//
//    public static let shared = AuthManager()
//
//
//    private init() {}
//
//
//    enum SignInMethod {
//
//        case email
//        case google
//        case apple
//    }
//
//    /// Represents errors that can occur in auth flows
//    enum AuthError: Error {
//        case signInFailed
//    }
//
//    private var currentUser: User?
//    //     Public
//    public var isSignedIn: Bool {
//        return currentUser != nil
//    }
//
//    public func logIn(firstName: String, password: String) -> Bool {
//        return DatabaseManager.shared.users.contains { $0.firstName == firstName && $0.password == password }
//    }
//
//    public func signIn(firstName: String, lastName: String, email: String) {
//        DatabaseManager.shared.saveUser(firstName: firstName, lastName: lastName, email: email, password: "1")
//    }
//
//    public func signOut() {
//        currentUser = nil
//    }
//}

 
 final class AuthManager {
      public static let shared = AuthManager()
      private init() {}
     
      enum SignInMethod {
          case email
          case google
          case apple
      }
     
      enum AuthError: Error {
          case signInFailed
          case userNotFound
          case invalidCredentials
      }
     
      public var isSignedIn: Bool {
          return SessionManager.shared.currentUser != nil
      }
     
      public func logIn(email: String, password: String) -> Result<String, Error> {
          // Check if user with the given email exists
          guard let user = UserManager.shared.findUserByEmail(email) else {
              return .failure(AuthError.userNotFound)
          }
         
          // Check if password is correct
          guard user.password == password else {
              return .failure(AuthError.invalidCredentials)
          }
         
          // Generate authentication token
          let token = UUID().uuidString
         
          // Store token and user email in the session manager
          SessionManager.shared.startSession(token: token, email: email)
         
          return .success(token)
      }
     
      public func signIn(firstName: String, lastName: String, email: String) {
          DatabaseManager.shared.saveUser(firstName: firstName, lastName: lastName, email: email, password: "1")
          SessionManager.shared.startSession(token: UUID().uuidString, email: email)
      }
     
      public func signOut() {
          SessionManager.shared.endSession()
      }
 }

 class UserManager {
      private var users: [User] = []
      static let shared = UserManager()
     
      func createUser(firstName: String, lastName: String, email: String, password: String) -> Result<User, Error> {
          guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty else {
              return .failure(AuthError.invalidInput)
          }
          if users.contains(where: { $0.email == email }) {
              return .failure(AuthError.userAlreadyExists)
          }
         
          // Create new user and add it to the list
          AuthManager.shared.signIn(firstName: firstName, lastName: lastName, email: email)
          let user = User(firstName: firstName, lastName: lastName, email: email, password: password)
          users.append(user)
         
          return .success(user)
      }
     
      func findUserByEmail(_ email: String) -> User? {
          return users.first(where: { $0.email == email })
      }
 }

 class AuthManagerb {
      static let shared = AuthManagerb()
      private init() {}
     
      func logOut() {
          SessionManager.shared.endSession()
      }
     
      var isLoggedIn: Bool {
          return SessionManager.shared.currentUser != nil
      }
 }

// class SessionManager {
//      static let shared = SessionManager()
//
//      private var sessions: [String: String] = [:] // token: email
//
//      private init() {}
//
//      var currentUser: User? {
//          guard let email = currentUserEmail else { return nil }
//          return UserManager.shared.findUserByEmail(email)
//      }
//
//      private var currentUserEmail: String? {
//          return UserDefaults.standard.string(forKey: "currentUserEmail")
//      }
//
//      var currentSession: String? {
//          return sessions.first(where: { $1 == currentUserEmail })?.key
//      }
//
//      func startSession(token: String, email: String) {
//          sessions[token] = email
//          UserDefaults.standard.set(email, forKey: "currentUserEmail")
//      }
//
//      func endSession() {
//          if let token = currentSession {
//              sessions.removeValue(forKey: token)
//          }
//          UserDefaults.standard.removeObject(forKey: "currentUserEmail")
//      }
// }

class SessionManager {
    static let shared = SessionManager()

    private let databaseManager = DatabaseManager.shared

    private var sessions: [String: String] = [:] // token: email

    private init() {}

    var currentUser: User? {
        guard let email = currentUserEmail else { return nil }
        return databaseManager.findUserByEmail(email)
    }

    private var currentUserEmail: String? {
        return UserDefaults.standard.string(forKey: "currentUserEmail")
    }

    var currentSession: String? {
        return sessions.first(where: { $1 == currentUserEmail })?.key
    }

    func startSession(token: String, email: String) {
        sessions[token] = email
        UserDefaults.standard.set(email, forKey: "currentUserEmail")
    }

    func endSession() {
        if let token = currentSession {
            sessions.removeValue(forKey: token)
        }
        UserDefaults.standard.removeObject(forKey: "currentUserEmail")
    }
}


 class DatabaseManager {
     static let shared = DatabaseManager()
     
     private let userDefaults = UserDefaults.standard
     
     private init() {}
     enum SettingKeys: String {
             case users
             case activeUser
         }
     
     func saveUser(firstName: String, lastName: String, email: String, password: String) {
         var users = loadUsers()
         let user = User(firstName: firstName, lastName: lastName, email: email, password: password)
         users.append(user)
         saveUsers(users)
     }
     
     func findUserByEmail(_ email: String) -> User? {
         let users = loadUsers()
         return users.first(where: { $0.email == email })
     }
     
     func loadUsers() -> [User] {
         guard let userJsonData = userDefaults.data(forKey: SettingKeys.users.rawValue) else {
             return []
         }
         let decoder = JSONDecoder()
         do {
             return try decoder.decode([User].self, from: userJsonData)
         } catch {
             print("Failed to decode user data: \(error.localizedDescription)")
             return []
         }
     }
     
     func saveUsers(_ users: [User]) {
         let encoder = JSONEncoder()
         do {
             let jsonData = try encoder.encode(users)
             userDefaults.set(jsonData, forKey: SettingKeys.users.rawValue)
         } catch {
             print("Failed to encode user data: \(error.localizedDescription)")
         }
     }
     
     func deleteAllUsers() {
             userDefaults.removeObject(forKey: SettingKeys.users.rawValue)
         }
 }
enum AuthError: Error {
case invalidInput
case userAlreadyExists
case userNotFound
case invalidCredentials
}
