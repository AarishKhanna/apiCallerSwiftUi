//
//  ContentView.swift
//  apiCallerSwiftUi
//
//  Created by Aarish Khanna on 11/01/23.
//

import SwiftUI

//import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = UsersViewModel()
    @State var currentTab = "Users"
    @Namespace var animation
    @Environment(\.colorScheme) var scheme
    
    var body: some View {

        NavigationView {
            
            VStack{

                
                ScrollViewReader{
                    proxy in
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 30){
                            ForEach(tabItems){
                                tab in
                                VStack{
                                    Text(tab.tab)
                                        .foregroundColor(
                                            
                                            currentTab == tab.tab ? (scheme == .dark ? .white: .black): .gray
                                        )
                                    if currentTab == tab.tab{
                                        Capsule()
                                            .fill(scheme == .dark ? .white: .black)
                                            .matchedGeometryEffect(id: "TAB", in: animation)
                                            .frame(height: 3)
                                            .padding(.horizontal, -10)
                                    } else{
                                        Capsule()
                                            .fill(.clear)
                                            .frame(height: 3)
                                            .padding(.horizontal, -10)
                                    }
                                }.onTapGesture {
                                    withAnimation(.easeInOut){
                                        currentTab = tab.tab
                                        if(currentTab == "To Dos"){
                                            vm.fetchToDos()
                                        }
                                        proxy.scrollTo(currentTab, anchor: .topTrailing)
                                    }
                                }
                            }
                        }.padding(.horizontal,30)
                    }
                }.padding(.top)
                
                
                
                
                
                ZStack {
                    
                    if vm.isRefreshing {
                        ProgressView()
                    }
                    
                    if(currentTab == "Users"){
                        List {
                            ForEach(vm.users, id: \.id) { user in
                                
                                    UserView(user: user)
                                    .listRowSeparator(.hidden)
                               
                            }
                        }
                        .listStyle(.plain)
                    }
                    
                    if(currentTab == "To Dos"){
                        
                        List {
                            ForEach(vm.todos, id: \.id) { todos in
   
                                ToDoListView(todos: todos)
                                .listRowSeparator(.hidden)
                               
                            }
                        }
                        .listStyle(.plain)
                    }
                }.onAppear(perform: vm.fetchUsers)
                .alert(isPresented: $vm.hasError,
                       error: vm.error) {
                    Button(action: vm.fetchUsers) {
                        Text("Retry")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
