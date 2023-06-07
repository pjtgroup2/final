//
//  Owner+CoreDataProperties.swift
//  group2 final
//
//  Created by snlcom on 2023/06/04.
//
//

import Foundation
import CoreData


extension Owner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Owner> {
        return NSFetchRequest<Owner>(entityName: "Owner")
    }

    @NSManaged public var age: String?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var isLoggedIn: Bool
    @NSManaged public var proposals: Proposal?

}

extension Owner : Identifiable {

}
