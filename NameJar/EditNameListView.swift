//
//  EditNameListView.swift
//  NameJar
//
//  Created by Kari Groszewska on 1/13/25.
//

import SwiftData
import SwiftUI

struct EditNameListView: View {
    @Bindable var nameList: NameList

    @State private var newName = ""
    @State private var randomName = ""

    var body: some View {
        Form {
            Section("List Name") {
                TextField("List Name", text: $nameList.title)
            }
            Section("Names") {
                ForEach(nameList.names) { name in
                    Text(name.firstName)
                }
                HStack {
                    TextField("Add to \(nameList.title)", text: $newName)
                    //add name to the list when enter is pressed
                    Button("Add", action: addName)
                }
            }
            Section("Selections") {
                HStack {
                    Text(randomName)
                    Spacer()
                    Button("Random Name", action: selectName)
                }
            }

        }
    }
    func addName() {
        guard newName.isEmpty == false else { return }
        withAnimation {
            let name = Name(firstName: newName)
            nameList.names.append(name)
            newName = ""
        }

    }
    func selectName() {
        let index = Int.random(in: 0..<nameList.names.count)
        randomName = nameList.names[index].firstName
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: NameList.self, configurations: config)
        let example = NameList(title: "Example")
        return EditNameListView(nameList: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
