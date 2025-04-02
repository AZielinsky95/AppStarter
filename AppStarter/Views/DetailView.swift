//
//  DetailView.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-04-02.
//

import SwiftUI
import SwiftUINavigation

struct DetailView: View {
 
    @State var model: SecondTabModel
    
    var body: some View {
        Color.red
            .overlay {
                VStack {
                    Button {
                        model.destination = .addItem(AddItemModel())
                    } label: {
                        Text("Add Item")
                    }
                    Button {
                        model.destination = .editItem(EditItemModel())
                    } label: {
                        Text("Edit Item")
                    }
                    Button {
                        model.destination = .deleteItemAlert
                    } label: {
                        Text("Delete Item")
                    }
                }

            }
            .sheet(item: $model.destination.addItem) { addItemModel in
                Color.green.overlay {
                    Text("Add Item")
                }
            }
            .alert("Delete?", isPresented: Binding($model.destination.deleteItemAlert)) {
              Button("Yes", role: .destructive) { /* ... */ }
              Button("No", role: .cancel) {}
            }
            .navigationDestination(item: $model.destination.editItem) { editItemModel in
                Color.purple.overlay {
                    Text("Edit Item")
                }
            }
    }
}
