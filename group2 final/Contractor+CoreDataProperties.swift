//
//  Contractor+CoreDataProperties.swift
//  group2 final
//
//  Created by snlcom on 2023/06/04.
//
//

import Foundation
import CoreData


extension Contractor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contractor> {
        return NSFetchRequest<Contractor>(entityName: "Contractor")
    }

    @NSManaged public var age: String?
    @NSManaged public var gender: String?
    @NSManaged public var job: String?
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var isLoggedIn: Bool
}

extension Contractor : Identifiable {

}
