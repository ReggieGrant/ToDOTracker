//
//  DashboardView.swift
//  ToDOTracker
//
//  Created by Reginald Grant on 7/1/26.
//

import SwiftUI

struct DashboardView: View {
    @State private var profiles: [Profile] = Profile.sample // initalize mock data
    @State private var path = NavigationPath()
    
    let columns = [
        GridItem(.flexible(), spacing:20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                ScrollView {
                    VStack(spacing: 40) {
                        VStack {
                            Text("Welcome to ToDoTracker App")
                                .font(.subheadline)
                                .textCase(.uppercase)
                                .foregroundColor(.brown)
                                .padding(.top, 40)
                            Text("Who is working today?")
                                .font(.system(size: 25, weight: .bold))
                        }
                        LazyVGrid(columns: columns, spacing: 25) {
                            ForEach($profiles) { $profile in
                                NavigationLink(value: profile) {
                                    ProfileCardView(profile: profile)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: Profile.self) {
                selectedProfile in if let index = profiles.firstIndex(where: {$0.id == selectedProfile.id}) { ContentView(profile: $profiles[index])}
            }
        }
    }
}

struct ProfileCardView: View {
    let profile: Profile
    
    var body: some View {
        VStack(spacing: 15) {
            ZStack {
                Image(profile.profileImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .frame(width: 120, height: 120)
            Text(profile.name)
                .font(.system(.headline, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.gray))
                .shadow(color:Color.green.opacity(0.2), radius: 15, x:0, y:15)
        )
    }
}
