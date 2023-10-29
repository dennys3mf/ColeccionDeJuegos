//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by J-E-M on 17/05/23.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let categorias = ["Plataforma","Shooters", "MetroidVenia","Casual","Terror"]
    var currentCategoria:String = ""
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorias.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorias[row]
    }
    
    
 
    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var descripcionTextField: UITextField!
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    
    @IBOutlet weak var categoriasPicker: UIPickerView!
    
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        navigationController?.popViewController(animated: true)
    }
    var imagePicker = UIImagePickerController()
    let comoboBoxTextField = UITextField()
    var juego:Juego? = nil
    
    @IBAction func agregarTapped(_ sender: Any) {
        
        if juego != nil {
            juego!.titulo! = tituloTextField.text!
            juego!.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.5)
            juego!.descripcion! = descripcionTextField.text!
            juego!.categoria! = currentCategoria
            
            
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = JuegoImageView.image?.jpegData(compressionQuality:0.50)
            juego.descripcion = descripcionTextField.text
            print(currentCategoria)
            juego.categoria = currentCategoria
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentCategoria = categorias[row]
    }
    
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        categoriasPicker.dataSource = self
        categoriasPicker.delegate = self
        print("editando")
        if juego != nil {
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            descripcionTextField.text = juego!.descripcion
            let posicion:Int = categorias.firstIndex(of: juego!.categoria!) ?? 0
            categoriasPicker.selectRow(posicion, inComponent: 0, animated: false)

            agregarActualizarBoton.setTitle(
                "Actualizar", for: .normal)
        }else {
            eliminarBoton.isHidden = true
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ocultarTeclado))
        view.addGestureRecognizer(tap)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        JuegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func ocultarTeclado(){
        view.endEditing(true)
    }

    

}
