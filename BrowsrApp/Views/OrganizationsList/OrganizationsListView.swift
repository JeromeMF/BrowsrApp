//
//  OrganizationsListView.swift
//  BrowsrApp
//
//  Created by Jérôme Figueiredo on 13/10/2022.
//

import SwiftUI

struct OrganizationsListView: View {
    // MARK: - Properties
    @StateObject var viewModel = OrganizationsListViewModel()
    @State var selection: String = ""
    @State var searchString: String = ""
    
    @Environment(\.dismissSearch) var dismissSearch
    @Environment(\.isSearching) var isSearching
    
    let sorting = ["followers", "repositories", "joined"]
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    
                    Picker("Sort", selection: $selection) {
                                    ForEach(sorting, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.menu)
                    
                    
//                    HStack() {
                        //                    Text("SearchBar")
                        
                        //                        TextField("Search", text: $searchString)
                        
//                        Spacer()
//
//                                            Button(action: {
//
//                                            }, label: {
//                                                HStack {
//                                                    Text("Sort")
//                                                    Image(systemName: "line.3.horizontal.decrease.circle")
//                                                }
//                                            })
                        
//                                            Picker("Sort", selection: $selection) {
//                                                            ForEach(SortingType, id: \.self) {
//                                                                Text($0)
//                                                            }
//                                                        }
//                                                        .pickerStyle(.menu)
                        
//                    }
//                    .padding([.horizontal, .bottom])
                    
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.organizations.indices, id: \.self) { index in
                                OrganizationView(organization: viewModel.organizations[index])
                                    .onAppear() {
                                        if !isSearching && searchString.isEmpty {
                                            viewModel.loadMoreOrganizations(index: index)
                                        }
                                    }
                            }
                        }
                    }
                    .searchable(text: $searchString, suggestions: {
                        //                        ForEach(viewModel.organizations, id: \.self) { name in
                        //                            Text(name.login)
                        //                                .searchCompletion(name.login)
                        //                        }
                    })
                    .onChange(of: searchString) { newString in
                        if newString.isEmpty {
                            viewModel.clearOrganizations()
                            viewModel.getOrganizations()
                        }
                    }
                    .onChange(of: selection) { sort in
                        viewModel.sortOrganization(sort)
                    }
                    .onSubmit(of: .search) { // Su
                        Task {
                            viewModel.searchOrganization(_: searchString)
                        }
                    }
                }
//                .padding(.top)
            }
        }
    }
}

// MARK: - Preview
struct OrganizationsListView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationsListView()
    }
}
