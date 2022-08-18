//
//  DetailViewController.swift
//  AppTVFinal
//
//  Created by Ricardo Omar Martinez Nava on 16/08/22.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var programa: Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard programa != nil else {
            print("Show vacio in DetailViewController")
            return
        }
        
        updateUserInterface()
    }
    
    func updateUserInterface() {
        nameLabel.text = programa.name
        
        programa.summary = programa.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        descriptionTextView.text = programa.summary ?? ""
        
        guard let url = URL(string: programa.image?.medium ?? "") else { return }
        do {
            let data = try Data(contentsOf: url)
            imageView.image = UIImage(data: data)
        } catch {
            print("Error ")
        }
        
        
        
        
        
    }

    @IBAction func webButton(_ sender: Any) {
        guard let sitio = URL(string: programa.url ?? "") else { return }
        let svc = SFSafariViewController(url: sitio)
        present(svc, animated: true, completion: nil)
    }
    
}
