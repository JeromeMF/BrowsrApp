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
    @State var sortSelection: String = "followers"
    @State var searchString: String = ""
    
    @Environment(\.dismissSearch) var dismissSearch
    @Environment(\.isSearching) var isSearching
    
    let sorting = ["followers", "repositories", "joined"]
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    
                    Picker("Sort", selection: $sortSelection) {
                                    ForEach(sorting, id: \.self) { sort in
                                        Text(sort)
                                    }
                                }
                                .pickerStyle(.menu)
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.organizations.indices, id: \.self) { index in
                                OrganizationView(organization: viewModel.organizations[index])
                                    .onAppear() {
                                        if !isSearching && searchString.isEmpty {
                                            viewModel.loadMoreOrganizations(index: index, sortType: sortSelection)
                                        }
                                    }
                            }
                        }
                    }
                    .searchable(text: $searchString, prompt: "Organization name", suggestions: {
                        //                        ForEach(viewModel.organizations, id: \.self) { name in
                        //                            Text(name.login)
                        //                                .searchCompletion(name.login)
                        //                        }
                    })
                    .onChange(of: searchString) { newString in
                        if newString.isEmpty {
                            viewModel.clearOrganizations()
                            viewModel.sortOrganization(sortSelection)
                        }
                    }
                    .onChange(of: sortSelection) { sort in
                        searchString = ""
                        viewModel.clearOrganizations()
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
