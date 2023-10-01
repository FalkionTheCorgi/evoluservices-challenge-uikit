//
//  ModalViewController.swift
//  ProjetoTeste
//
//  Created by Manollo on 30/09/23.
//

import Foundation
import UIKit

class ModalViewController: UIViewController{
    
    
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var titleBottomSheet: UILabel!
    @IBOutlet weak var titleTextEditing: UITextField!
    @IBOutlet weak var descriptionTextEditing: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    var passTitle: String = ""
    var passDescription : String = ""
    var isEdit : Bool = false
    var id: String = ""
    
    let model = ModalViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillScreen()
        setupBottomSheetView()
        keyBoarRecongnizer()
        observerTextField()
   
    }
    
    func fillScreen(){
        
        titleBottomSheet.text = isEdit ? "EDITAR TAREFA" : "ADICIONAR TAREFA"
        titleTextEditing.text = passTitle
        descriptionTextEditing.text = passDescription
        model.buttonTitle = isEdit ? "EDITAR" : "ADICIONAR"
        btnAdd.setTitle(model.buttonTitle, for: .normal)
        
    }
    
    func verifyTextField(title: String?, description: String?) -> Bool {
        
        if title != nil {
            
            if(title!.isEmpty){
                titleTextEditing.layer.borderColor = UIColor.red.cgColor
                
            } else {
                titleTextEditing.layer.borderColor = UIColor.gray.cgColor
            }
            
        }
        
        if description != nil {
            
            if(description!.isEmpty){
                
                descriptionTextEditing.layer.borderColor = UIColor.red.cgColor
                
                return false
                
            } else {
                
                descriptionTextEditing.layer.borderColor = UIColor.gray.cgColor
                return true
                
            }
            
        } else {
            
            return false
            
        }
        
    }
    
    func observerTextField(){
        titleTextEditing.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        descriptionTextEditing.addTarget(self, action: #selector(descriptionTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func titleTextFieldDidChange(_ textField: UITextField) {
        let _ = verifyTextField(title: textField.text, description: nil)
    }
    
    @objc func descriptionTextFieldDidChange(_ textField: UITextField) {
        let _ = verifyTextField(title: nil, description: textField.text)
   }
    
    
    func keyBoarRecongnizer(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    deinit {
        // Não se esqueça de remover as observações quando a view for desalocada
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y = -300
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = self.view.frame.origin.y + 300
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupBottomSheetView(){
        
        bottomSheetView.layer.cornerRadius = 12.0
        titleTextEditing.layer.borderWidth = 0.5
        descriptionTextEditing.layer.borderWidth = 0.5
        
    }
    
    @IBAction func addItem(_ sender: Any) {
        if(verifyTextField(title: titleTextEditing.text, description: descriptionTextEditing.text)){
            if isEdit{
                model.editData(id: id, title: titleTextEditing.text ?? passTitle, description: descriptionTextEditing.text ?? passDescription)
            }else{
                model.saveData(title: titleTextEditing.text ?? "", description: descriptionTextEditing.text ?? "")
            }
            dismiss(animated: true)
        }
    }
    
    @IBAction func closeSheet(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
