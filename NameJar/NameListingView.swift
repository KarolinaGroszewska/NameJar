//
//  NameListingView.swift
//  NameJar
//
//  Created by Kari Groszewska on 1/13/25.
//

import SwiftData
import SwiftUI

struct NameListingView: View {
    init(searchString: String) {
        _nameList = Query(
            filter: #Predicate {
                if searchString.isEmpty {
                    return true
                } else {
                    return $0.title.localizedStandardContains(searchString)
                }
            }, sort: \NameList.title)
    }

    @Environment(\.modelContext) var modelContext

    @Query var nameList: [NameList]

    var body: some View {
        List {
            ForEach(nameList) { nameList in
                NavigationLink(value: nameList) {
                    Text(nameList.title)
                        .font(.headline)
                }
            }
            .onDelete(perform: deleteNameList)
        }
    }
    func deleteNameList(_ indexSet: IndexSet) {
        for index in indexSet {
            let nameList = nameList[index]
            modelContext.delete(nameList)
        }
    }
}

#Preview {
    NameListingView(searchString: "")
}
