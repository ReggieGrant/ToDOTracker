//
//  GroupStatsView.swift
//  ToDOTracker
//
//  Created by Reginald Grant on 6/24/26.
//

import SwiftUI

struct GroupStatsView: View {
    var tasks: [TaskItem]
    // calculation of completion tasks
    var completedCount: Int {
        tasks.filter { $0.isCompleted }.count}
    // calculation of percentage
    var progress: Double { tasks.isEmpty ? 0 : Double(completedCount) / Double(tasks.count) }
    
    
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.2)
                    .foregroundColor(.cyan)
                
                
                // Completed Circle
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth:10, lineCap: .round))
                    .foregroundColor(.cyan)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .bold()
            }
            .frame(width:50, height:50)
            .padding()
            
            // Text Information
            VStack(alignment: .leading){
                Text("Progress of my tasks")
                    .font(.headline)
                    .foregroundStyle(.brown)
                Text("\(completedCount) / \(tasks.count) completed")
                    .font(.title2)
                    .bold()
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}


