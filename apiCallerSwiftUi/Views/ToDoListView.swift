//
//  ToDoListView.swift
//  apiCallerSwiftUi
//
//  Created by Aarish Khanna on 11/01/23.
//

import SwiftUI

struct ToDoListView: View {
    let todos: ToDoListItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("**Id**: \(todos.id)")
            Text("**Title**: \(todos.title)")

        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 4)
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(todos: .init(id:0,
                                       title: "Tunde Adegoroye"))
    }
}
