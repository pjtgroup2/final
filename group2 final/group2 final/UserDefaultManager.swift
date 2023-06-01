//
//  UserDefaultManager.swift
//  group2 final
//
//  Created by snlcom on 2023/06/01.
//

import Foundation

struct UserDefaultManager {
    static var shared = UserDefaultManager()
    
    private let userDefaults = UserDefaults.standard
    
    private let ownerKey = "OwnerInformation"
    private let contractorKey = "ContractorInformation"
    
    var ownerinformation: OwnerInformation? {
        get {
            if let data = userDefaults.data(forKey : ownerKey),
               let ownerinformation = try? JSONDecoder().decode(OwnerInformation.self, from : data) {
                return ownerinformation
            }
            return nil
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                userDefaults.set(encodedData, forKey: ownerKey)
            } else {
                userDefaults.removeObject(forKey: ownerKey)
            }
        }
    }
    
    var contractorInformation: ContractorInformation? {
        get{
            if let data = userDefaults.data(forKey : contractorKey),
               let contractorInformation = try? JSONDecoder().decode(ContractorInformation.self, from : data) {
                return contractorInformation
            }
            return nil
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                userDefaults.set(encodedData, forKey:contractorKey)
            } else {
                userDefaults.removeObject(forKey: contractorKey)
            }
        }
    }
}

struct OwnerInformation: Codable {
    let name : String
    let gender : String
    let age : String
    let phonenumber : String
}

struct ContractorInformation: Codable {
    let name : String
    let gender : String
    let age : String
    let phonenumber : String
    let job : String
}
