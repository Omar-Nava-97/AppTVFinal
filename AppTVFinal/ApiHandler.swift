//
//  ApiHandler.swift
//  AppTVFinal
//
//  Created by Ricardo Omar Martinez Nava on 17/08/22.
//

import Foundation

class ApiHandler {
    static let shared = ApiHandler()
    
    var urlString = "https://api.tvmaze.com/shows/1"
    
    var showArray: [Returned] = []
    
    struct Returned: Codable {
       // var score: Double
        var name: String
        var show: Show
        
        static let database = DaatabaseHandler.shared
        func store() {
            guard let user = Show.database.add(User.self) else { return}
            user.name = name
        }
        
    }
    
    
    func syncUsers(completed: @escaping () -> () ) {
        print("Accesar al url \(urlString)")
        
        //Crear URL
        guard let url = URL(string: urlString) else {
            print("Error")
            completed()
            return
        }
        
        //Crear la sesion
        let session = URLSession.shared
        
        //Obtener datos
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            do {
                self.showArray = try JSONDecoder().decode([Returned].self, from: data!)
                
                self.showArray.forEach {  $0.store() }
                
                print("\(self.showArray)")
            } catch {
                print("Json error: \(error.localizedDescription)")
            }
            
            completed()
        }
        
        task.resume()
                
    }
    
}
 


