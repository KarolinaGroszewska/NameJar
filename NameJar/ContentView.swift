//
//  ContentView.swift
//  NameJar
//
//  Created by Kari Groszewska on 1/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showAlert = false
    @State private var text: String = ""
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [NameList]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        DetailView()
                    } label: {
                        Text(item.title)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        showAlert = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .alert(
            Text("Add a Name List"),
            isPresented: $showAlert
        ) {
            Button("Cancel", role: .cancel) {
                // Handle the acknowledgement.
            }
            Button("OK") {
                addItem()
                text = ""
                // Handle the acknowledgement.
            }
            TextField("Title", text: $text)
                .textContentType(.name)
        } message: {
           Text("Enter a list title below.")
        }
    }
    

    private func addItem() {
        withAnimation {
            let newItem = NameList(title: text, nameList: [Name]())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: NameList.self, inMemory: true)
}
