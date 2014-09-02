//
//  Opiniao.swift
//  CocoaQuiz
//
//  Created by Regis Araujo Melo on 25/08/14.
//  Copyright (c) 2014 Swift Dojo. All rights reserved.
//

import Foundation
import CoreData

class Opiniao: NSManagedObject {

    @NSManaged var nota: NSNumber
    @NSManaged var primeiroNome: String
    @NSManaged var sobreNome: String
    @NSManaged var timeStamp: NSDate

}
