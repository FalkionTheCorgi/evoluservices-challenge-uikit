//
//  ModalViewModel.swift
//  ProjetoTeste
//
//  Created by Manollo on 30/09/23.
//

import Foundation

class ModalViewModel{
    
    var buttonTitle = "ADICIONAR"
    
    //método para converter uma data e hora em string
    func getDate() -> String{
        
        let now = Date() // Obtém a data e hora atuais

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss" // Define o formato de data e hora desejado
        dateFormatter.locale = Locale.current // Define a localização atual para obter a hora local

        let dateHour = dateFormatter.string(from: now) // Converte a data em uma string formatada

        return dateHour
        
    }
    
    func saveData(title: String, description: String) {
        
        DispatchQueue.main.async{
            self.buttonTitle = "CARREGANDO"
        }
        
        let coreData = PersistenceController.shared
        
        coreData.saveItem(title: title, description: description, date: getDate()){ result in
            switch result{
                
            case .success(_):
                
                break
            case .failure(let error):
                print("Erro ao salvar os dados: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async{
                self.buttonTitle = "ADICIONAR"

            }
                
        }
        
    }
    
    func editData(id: String, title: String, description: String) {

        DispatchQueue.main.async{
            self.buttonTitle = "CARREGANDO"
        }
        
        let coreData = PersistenceController.shared
        
        coreData.updateItem(id: id, title: title, description: description, date: getDate()){ result in
            switch result{
                
            case .success(_):
                break
            case .failure(let error):
                print("Erro ao salvar os dados: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async{
                self.buttonTitle = "EDITAR"
            }
            
        }

    }
    
    
}
