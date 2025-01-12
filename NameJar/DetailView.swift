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
    
    @State private var showAlert = false
    @State private var text: String = ""

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
                        showAlert = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .alert(
                Text("Add a Name"),
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
                TextField("Name", text: $text)
                    .textContentType(.name)
            } message: {
               Text("Enter a name below.")
            }
        }
    
    private func addItem() {
        withAnimation {
            let newItem = Name(firstName: text)
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
