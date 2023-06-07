//
//  Proposal+CoreDataProperties.swift
//  group2 final
//
//  Created by snlcom on 2023/06/04.
//
//

import Foundation
import CoreData


extension Proposal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Proposal> {
        return NSFetchRequest<Proposal>(entityName: "Proposal")
    }

    @NSManaged public var additionalDetails: String?
    @NSManaged public var location: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var workName: String?
    @NSManaged public var owner: Owner?

}

extension Proposal : Identifiable {

}
