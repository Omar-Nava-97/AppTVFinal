//
//  ViewController.swift
//  AppTVFinal
//
//  Created by Ricardo Omar Martinez Nava on 16/08/22.
//

import UIKit
import AVFoundation

class ListViewViewController: UIViewController {
    
    @IBOutlet weak var tablaProgramas: UITableView!
    
    var audioPlayer: AVAudioPlayer!
    
    var programas = Programas()
    
    var programaSeleccionado: Show?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tablaProgramas.register(UINib(nibName: "CeldaProgramaTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        tablaProgramas.delegate = self
        tablaProgramas.dataSource = self
        
        programas.getData {
            DispatchQueue.main.async {
                self.tablaProgramas.reloadData()
            }
        }
        
        playSound(sonido: "sound2")
    }
    
    func playSound(sonido: String) {
        if let sound = NSDataAsset(name: sonido) {
            do {
                audioPlayer = try AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("Error: No se inicilizo el AVAudioPlayer: \(error.localizedDescription)")
            }
            
        } else {
            print("Error: No recibe informacion del archivo: \(sonido)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController
        let selectedIndexPath = tablaProgramas.indexPathForSelectedRow!
        destination.programa = programas.showArray[selectedIndexPath.row].show
    }
    

}




extension ListViewViewController: UITableViewDelegate, UITableViewDataSource  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programas.showArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! CeldaProgramaTableViewCell
        
        //cell.textLabel?.text = programas.showArray[indexPath.row].show.name
        cell.namePrograma.text = programas.showArray[indexPath.row].show.name
        //cell.imagePrograma.image = UIImage(named: "tv")
        if let urlString = programas.showArray[indexPath.row].show.image?.medium as? String {
            if let imagenURL = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL) else {
                        return
                    }
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        cell.imagePrograma.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        programaSeleccionado = programas.showArray[indexPath.row].show
        
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accionFavorite = UIContextualAction(style: .normal, title: "Favorite") { (_, _, _) in
            
            let alerta = UIAlertController(title: "Agregar a Favoritos", message: "¿Seguro que quieres agregarlo a favoritos?", preferredStyle: .alert)
            
            let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
                print("Agregado a favoritos Correctamente")
            }
            
            let accionCancelar = UIAlertAction(title: "Cancelar", style: .destructive)
            
            self.present(alerta, animated: true)
            
            alerta.addAction(accionCancelar)
            alerta.addAction(accionAceptar)
            
            print("Favorite")
        }
        accionFavorite.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [accionFavorite])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accionBorrar = UIContextualAction(style: .normal, title: "Delete") { (_, _, _) in
            
            let alerta = UIAlertController(title: "Eliminar", message: "¿Seguro que quieres eliminar este programa?", preferredStyle: .alert)
            
            let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
                print("Eliminado Correctamente")
            }
            
            let accionCancelar = UIAlertAction(title: "Cancelar", style: .destructive)
            
            self.present(alerta, animated: true)
            
            alerta.addAction(accionCancelar)
            alerta.addAction(accionAceptar)
    }
        accionBorrar.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [accionBorrar])
    
    }

}
