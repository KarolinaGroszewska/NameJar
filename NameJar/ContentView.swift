//
//  ContentView.swift
//  NameJar
//
//  Created by Kari Groszewska on 1/11/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    @Environment(\.modelContext) var modelContext

    @State private var path = [NameList]()
    @State private var sortOrder = SortDescriptor(\NameList.title)
    @State private var searchText = ""

    var body: some View {
        NavigationStack(path: $path) {
            NameListingView(searchString: searchText)
                .searchable(text: $searchText)
                .navigationTitle("Name Jar")
                .navigationDestination(for: NameList.self) { nameList in
                    EditNameListView(modelContext: _modelContext, nameList: nameList)
                }
                .toolbar {
                    Button("Add List", systemImage: "plus", action: addItem)
                }
        }
    }

    private func addItem() {
        let nameList = NameList()
        modelContext.insert(nameList)
        path = [nameList]
    }
}

#Preview {
    ContentView()
        .modelContainer(for: NameList.self, inMemory: true)
}
