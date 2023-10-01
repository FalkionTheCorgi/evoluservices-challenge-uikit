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
    
    
    init(tableView: UITableView) {
        
        getTasks(tableView: tableView)
        atualizarLista(tableView: tableView)
        
    }
    
    

    
    func getTasks(tableView: UITableView) {
        
        let coreData = PersistenceController.shared

        cancellable = coreData.dataChangedPublisher
            .sink(receiveValue: { [weak self] _ in
                self?.atualizarLista(tableView: tableView)
            })

        
    }
    
    private func atualizarLista(tableView: UITableView) {
        
        // Obtenha os dados do banco de dados
        let itemsFromDatabase = PersistenceController.shared.getAllItems()
        
        DispatchQueue.main.async {
            self.items.accept(itemsFromDatabase)
            tableView.reloadData()
        }
        
    }
    
    func deleteItem(item: Item, tableView: UITableView){
        
        let coreData = PersistenceController.shared
        
        coreData.deleteItem(item: item)

        tableView.endUpdates()
        
    }
    
    
}
