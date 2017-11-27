//
//  Item+CoreDataClass.swift
//  WishBox
//
//  Created by Shehryar Khan on 27.11.17.
//  Copyright © 2017 Shehryar Khan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    public override func awakeFromInsert() {
  
        super.awakeFromInsert()
        self.created = NSDate()
    }

}
