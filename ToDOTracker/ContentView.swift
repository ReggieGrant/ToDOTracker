//
//  ContentView.swift
//  ToDOTracker
//
//  Created by Reginald Grant on 6/22/26.
//

import SwiftUI

struct ContentView: View {
    @State private var taskGroups : [TaskGroup] = []
    @State private var selectedGroup: TaskGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "savedTaskGroupsKey"
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // COLUMN 1 : SIDEBAR
            List(selection: $selectedGroup) {
                ForEach(taskGroups) { group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle(Text("ToDoTracker"))
            .listStyle(.sidebar)
            .toolbar {
                Button {
                    isShowingAddGroup = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        } detail: {
            // COLUMN 2 : DETAILS (selected group)
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: { $0.id == group.id }) {
                    TaskDetailView(group: $taskGroups[index])
                }
            } else {
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
        }
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
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
        if let encodeData = try? JSONEncoder().encode(taskGroups) {
            UserDefaults.standard.set(encodeData, forKey: saveKey)
            // What do you want to save, Where
        }
    }
    // Look for stored Data JSON data -> Array
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
                taskGroups = decodedGroups
                return
            }
        }
        taskGroups = TaskGroup.sampleData
    }
}


