//
//  DetailViewController.swift
//  ProjetoTeste
//
//  Created by Manollo on 30/09/23.
//

import Foundation
import UIKit

class DetailViewController: UIViewController{
 
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    var passTitle = ""
    var passDescription = ""
    var passData = ""
    
    
    override func viewDidLoad() {
        fillScreen()
        configureNavBar()
        super.viewDidLoad()
    }
    
    func fillScreen(){
        
        let bold: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16) // Substitua pelo tamanho e estilo de fonte desejados
        ]
        let titleAtribuido = NSMutableAttributedString(string: "Título: ", attributes: bold)
        let passTitleNS = NSAttributedString(string: passTitle)
        titleAtribuido.append(passTitleNS)
        titleLabel.attributedText = titleAtribuido

        let descriptAtribuido = NSMutableAttributedString(string: "Descrição: ", attributes: bold)
        let passDescriptNS = NSAttributedString(string: passDescription)
        descriptAtribuido.append(passDescriptNS)
        descriptionLabel.attributedText = descriptAtribuido
        
        let dateAtributed = NSMutableAttributedString(string: "Data: ", attributes: bold)
        let passDataNS = NSAttributedString(string: passData)
        dateAtributed.append(passDataNS)
        dataLabel.attributedText = dateAtributed
        
    }
    
    func configureNavBar(){
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(voltar))
        backButton.tintColor = UIColor(named: "TitleColor")
        navigationItem.leftBarButtonItem = backButton
        title = "Detalhes"
        
    }
    
    @objc func voltar() {
        navigationController?.popViewController(animated: true)
    }

    
}
