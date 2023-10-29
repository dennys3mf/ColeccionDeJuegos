//
//  ViewController.swift
//  ColeccionDeJuegos
//
//  Created by J-E-M on 17/05/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var juegos: [Juego] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                        _ = UITableViewCell()
                let juego = juegos[indexPath.row]
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                        context.delete(juego)
                (UIApplication.shared.delegate as!  AppDelegate).saveContext()
                juegos.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let movedObject = juegos[sourceIndexPath.row]
                juegos.remove(at: sourceIndexPath.row)
                juegos.insert(movedObject, at:destinationIndexPath.row)
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        juegos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let juego = juegos[indexPath.row]
        cell.textLabel?.text = juego.titulo
        cell.imageView?.image = UIImage(data: (juego.imagen!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let juego = juegos[indexPath.row]
        print("holaaaaaaaaa")
        performSegue(withIdentifier: "juegoSegue", sender: juego)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! JuegosViewController
        siguienteVC.juego = sender as? Juego
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! 	AppDelegate).persistentContainer.viewContext
        do{
            try juegos = 	context.fetch(Juego.fetchRequest())
            tableView.reloadData()
            
        }catch {
            
        }
    }
    
   

}

