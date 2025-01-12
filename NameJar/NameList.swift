//
//  NameList.swift
//  NameJar
//
//  Created by Kari Groszewska on 1/11/25.
//

import Foundation
import SwiftData

@Model
final class NameList {
    var title: String
    var nameList: [Name]
    
    init(title: String, nameList: [Name]) {
        self.title = title
        self.nameList = nameList
    }
}
