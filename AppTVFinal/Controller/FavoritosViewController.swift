//
//  FavoritosViewController.swift
//  AppTVFinal
//
//  Created by Ricardo Omar Martinez Nava on 17/08/22.
//

import UIKit

class FavoritosViewController: UIViewController {

    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var tableFavoritos: UITableView!
    
    let database = DaatabaseHandler.shared
    
    var users: [User]? {
        didSet{
            DispatchQueue.main.async {
                self.tableFavoritos.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableFavoritos.dataSource = self
        tableFavoritos.delegate = self
        tableFavoritos.register(UITableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        tableFavoritos.tableFooterView = UIView(frame: .zero)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        users = database.fetch(User.self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        ApiHandler.shared.syncUsers {
            self.users = self.database.fetch(User.self)
            
        }
    }
    

    @IBAction func onSave(_ sender: Any) {
        guard let user = database.add(User.self) else { return }
        guard let name = textName.text else { return }
        user.name = name
        users?.append(user)
        database.save()
    }

}

extension FavoritosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell")!
        cell.textLabel?.text = users?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alerta = UIAlertController(title: "Eliminar", message: "¿Seguro que quieres eliminar este programa?", preferredStyle: .alert)
            
            let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
                guard let user = self.users?[indexPath.row] else { return }
                tableView.beginUpdates()
                self.database.delete(object: user)
                self.users?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
            
            let accionCancelar = UIAlertAction(title: "Cancelar", style: .destructive)
            
            self.present(alerta, animated: true)
            
            alerta.addAction(accionCancelar)
            alerta.addAction(accionAceptar)
            
        }
    }
    
    
    
    
    
}

class UserTableViewCell: UITableViewCell {
    
}





