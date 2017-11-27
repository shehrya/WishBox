//
//  Image+CoreDataProperties.swift
//  WishBox
//
//  Created by Shehryar Khan on 27.11.17.
//  Copyright © 2017 Shehryar Khan. All rights reserved.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toStore: NSSet?
    @NSManaged public var toItem: Item?

}

// MARK: Generated accessors for toStore
extension Image {

    @objc(addToStoreObject:)
    @NSManaged public func addToToStore(_ value: Store)

    @objc(removeToStoreObject:)
    @NSManaged public func removeFromToStore(_ value: Store)

    @objc(addToStore:)
    @NSManaged public func addToToStore(_ values: NSSet)

    @objc(removeToStore:)
    @NSManaged public func removeFromToStore(_ values: NSSet)

}
