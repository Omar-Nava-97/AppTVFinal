//
//  Programas.swift
//  AppTVFinal
//
//  Created by Ricardo Omar Martinez Nava on 16/08/22.
//

import Foundation

class Programas {
    static let shared = Programas()
    var urlString = "https://api.tvmaze.com/schedule"
    
    var showArray: [Returned] = []
    
    struct Returned: Codable {
       // var score: Double
        var show: Show
    }
    
    
    func getData(completed: @escaping () -> () ) {
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
                
                print("\(self.showArray)")
            } catch {
                print("Json error: \(error.localizedDescription)")
            }
            
            completed()
        }
        
        task.resume()
                
    }
    
}

