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
    @Relationship(deleteRule: .cascade) var names = [Name]()
    
    init(title: String = "") {
        self.title = title
    }
}
