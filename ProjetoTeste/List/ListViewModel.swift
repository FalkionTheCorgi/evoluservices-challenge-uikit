//
//  ListViewModel.swift
//  ProjetoTeste
//
//  Created by Manollo on 30/09/23.
//

import Foundation
import Combine
import UIKit
import RxCocoa
import RxSwift

class ListViewModel {
    
    var items = BehaviorRelay<[Item]>(value: [])
    private var cancellable: AnyCancellable?
    
    
    init() {
        
        getTasks()
        atualizarLista()
        
    }
    
    

    
    func getTasks() {
        
        let coreData = PersistenceController.shared

        cancellable = coreData.dataChangedPublisher
            .sink(receiveValue: { [weak self] _ in
                self?.atualizarLista()
            })

        
    }
    
    private func atualizarLista() {
        
        // Obtenha os dados do banco de dados
        let itemsFromDatabase = PersistenceController.shared.getAllItems()
        
        DispatchQueue.main.async {
            self.items.accept(itemsFromDatabase)
        }
        
    }
    
    func deleteItem(item: Item){
        
        let coreData = PersistenceController.shared
        
        coreData.deleteItem(item: item)
        
    }
    
    
}
