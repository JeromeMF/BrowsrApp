//
//  OrganizationView.swift
//  BrowsrApp
//
//  Created by Jérôme Figueiredo on 16/10/2022.
//

import SwiftUI

struct OrganizationView: View {
    // MARK: - Properties
    var organization: Item
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            AsyncImage(url: URL(string: organization.avatarURL),
                       content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                //                                                .frame(maxWidth: 300, maxHeight: 100)
            },
                       placeholder: {
                ProgressView()
            })
            
            .frame(width: 70.0, height: 70.0, alignment: .center)
            .cornerRadius(20)
            .padding([.vertical, .leading], 10)
            .padding(.trailing, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack (alignment: .top){
                    Text("Name:")
                        .fontWeight(.semibold)
                    Text("\(organization.login)")
                        .padding(.trailing)
                }
                
                HStack (alignment: .top){
                    Text("URL:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .bold()
                    Text("\(organization.url)")
                        .font(.callout)
                }
                
            }
            .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
                
            }, label: {
            
            Image(systemName: "heart")
                .resizable()
                .foregroundColor(.pink)
                .frame(width: 20, height: 20)
                .padding(.trailing)
                    
            })
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 150, alignment: .leading)
        .background(Color.gray)
        .cornerRadius(10.0)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 0)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}

// MARK: - Preview
struct OrganizationView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationView(organization: Item(login: "microsoft",
                                            id: 1,
                                            nodeID: "MDEyOk9yZ2FuaXphdGlvbjYxNTQ3MjI",
                                            avatarURL: "https://avatars.githubusercontent.com/u/6154722?v=4",
                                            gravatarID: "",
                                            url: "https://api.github.com/users/microsoft",
                                            htmlURL: "",
                                            followersURL: "",
                                            subscriptionsURL: "",
                                            organizationsURL: "",
                                            reposURL: "",
                                            receivedEventsURL: "",
                                            type: "",
                                            score: 1,
                                            followingURL: "",
                                            gistsURL: "",
                                            starredURL: "",
                                            eventsURL: "",
                                            siteAdmin: true))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
