//
//  AstronautView.swift
//  Moonshot
//
//  Created by Nurbergen Yeleshov on 05.04.2021.
//

import SwiftUI

struct AstronautView: View {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    struct AstronautMission {
        let missionName: String
        let mission: Mission
    }
    let astronaut: Astronaut
    var astronautMissions = [AstronautMission]()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    Text(astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    ForEach(astronautMissions, id: \.missionName) { mission in
                        HStack {
                            Image(mission.mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                            VStack(alignment: .leading) {
                                Text(mission.missionName)
                                    .font(.headline)
                                Text(mission.mission.formattedLaunchDate)
                            }
                            Spacer()
                        }
                        .padding(.leading)
                    }
                }
                .navigationBarTitle(astronaut.name)
            }
        }
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        var matchedMissions = [AstronautMission]()
        for mission in missions {
            for crew in mission.crew {
                if crew.name == astronaut.id {
                    matchedMissions.append(AstronautMission(missionName: mission.displayName, mission: mission))
                }
            }
        }
        self.astronautMissions = matchedMissions
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var astronaut: [Astronaut] = Bundle.main.decode("astronaut.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronaut[0])
    }
}
