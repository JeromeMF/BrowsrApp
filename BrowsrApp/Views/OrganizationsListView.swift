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
    
    
    // MARK: - Body
    var body: some View {
        ZStack {
            
            ScrollView {
                LazyVStack {
                    //                List()
                    ForEach(viewModel.organizations, id: \.self) { value in
                        Text("\(value.login)")
//                            .onAppear() {
//                                viewModel.loadMoreOrganizations(currentItem: value)
//                            }
                        
                        Button(action: {
                            viewModel.loadMoreOrganizations(currentItem: value)
                        }, label: { Text("YOOOOO!")})
                    }
                }
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
