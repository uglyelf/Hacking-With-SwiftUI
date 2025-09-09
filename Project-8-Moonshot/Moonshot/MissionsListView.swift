//
//  MissionsListView.swift
//  Moonshot
//
//  Created by Gregory Randolph on 7/22/25.
//

import SwiftUI

struct MissionsListView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        
        List {
            ForEach(missions) { mission in
                Section {
                    NavigationLink(value: mission) {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .greatestFiniteMagnitude)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    } // NavigationLink
                }
                .listRowBackground(Color.darkBackground)
            } // ForEach
        }
        .listStyle(.plain)
        .background(.darkBackground)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    MissionsListView(astronauts: astronauts, missions: missions)
}
