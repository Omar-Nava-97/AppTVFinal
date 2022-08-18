//
//  userModelServer.swift
//  AppTVFinal
//
//  Created by Ricardo Omar Martinez Nava on 17/08/22.
//

import Foundation

struct UserServerModel: Codable {
    let name: String
    
    static let databaase = DaatabaseHandler.shared
    
    func store() {
        guard let user = UserServerModel.databaase.add(User.self) else { return }
        user.name = name
        UserServerModel.databaase.save()
    }
}
