//
//  DetailView.swift
//  NameJar
//
//  Created by Kari Groszewska on 1/11/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var nameList: [Name]

    var body: some View {
            List {
                ForEach(nameList) { name in
                    Text(name.firstName)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        addItem()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    
    private func addItem() {
        withAnimation {
            let newItem = Name(firstName: "Name")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(nameList[index])
            }
        }
    }
}

#Preview {
   DetailView()
}
