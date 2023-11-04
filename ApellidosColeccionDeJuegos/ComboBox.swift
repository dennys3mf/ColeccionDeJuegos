//
//  ComboBox.swift
//  ColeccionDeJuegos
//
//  Created by J-E-M on 17/05/23.
//

import Foundation

class ComboBox: UITextField, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComboBox()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupComboBox()
    }
    
    private func setupComboBox() {
        delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Aquí puedes mostrar el UIPickerView o cualquier otra lógica que desees
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Otros métodos y lógica que puedas necesitar
    
}
