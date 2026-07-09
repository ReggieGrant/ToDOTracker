//
//  ContentView.swift
//  ToDOTracker
//
//  Created by Reginald Grant on 6/22/26.
//

import SwiftUI

struct ContentView: View {
    @Binding var profile: Profile
    @State private var taskGroups : [TaskGroup] = []
    @State private var selectedGroup: TaskGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "savedTaskGroupsKey"
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // COLUMN 1 : SIDEBAR
            List(selection: $selectedGroup) {
                ForEach(profile.groups) { group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                    .accessibilityIdentifier("GroupNameLink\(group.title)")
                }
            }
            .navigationTitle(Text(profile.name))
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size:16, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(Circle().fill(Color.primary.opacity(0.1)))
                    }
                    .accessibilityIdentifier("BackButton")
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingAddGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("AddGroupButton")
                }
            }
        } detail: {
            // COLUMN 2 : DETAILS (selected group)
            if let group = selectedGroup {
                if let index = profile.groups.firstIndex(where: { $0.id == group.id }) {
                    TaskDetailView(group: $profile.groups[index])
                }
            } else {
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                profile.groups.append(newGroup)
                selectedGroup = newGroup // auto-navigate to the group selected
            }
        }
        .onAppear() {
            loadData()
        }
        .onChange(of: scenePhase){oldValue, newValue in
            if newValue == .active {
                print("User is active on the app")
            } else if newValue == .inactive {
                print("User is looking at someting else")
            } else if newValue == .background {
                saveData()
            }
        }
    }
    // Convert Array -> JSON Data
    func saveData(){
        if let encodeData = try? JSONEncoder().encode(profile.groups) {
            UserDefaults.standard.set(encodeData, forKey: saveKey)
            // What do you want to save, Where
        }
    }
    // Look for stored Data JSON data -> Array
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
                profile.groups = decodedGroups
                return
            }
        }
        // show mock data for dev purposes
        if profile.groups.isEmpty {
            profile.groups = TaskGroup.sampleData
        }
    }
}


