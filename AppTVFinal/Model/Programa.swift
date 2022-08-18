//
//  Programa.swift
//  AppTVFinal
//
//  Created by Ricardo Omar Martinez Nava on 16/08/22.
//

import Foundation

struct Show: Codable {
    var name: String
    var url: String
    var image: Image?
    var summary: String?
    var rating: Rating?
    
    static let database = DaatabaseHandler()
    func store() {
        guard let user = Show.database.add(User.self) else { return}
        user.name = name
    }
    
}

struct Rating: Codable{
    var average: Double?
}

struct Image: Codable {
    var medium: String?
    var original: String?
}
