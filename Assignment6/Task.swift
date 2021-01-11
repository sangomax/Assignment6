//
//  Task.swift
//  Assignment6
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-08.
//

import Foundation

struct Task {
    var check: Bool
    var name: String
    var desc: String
    var priority: String
    
    
    init(lName: String, lDesc: String, lPrio: String) {
        check = true
        name = lName
        desc = lDesc
        priority = lPrio
    }
}
