//
//  ViewController.swift
//  ProjetoTeste
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    /// Tabela que exibe as tarefas existentes
    @IBOutlet weak var emptyListView: UIView!
    @IBOutlet weak var tableView: UITableView!
    private lazy var model : ListViewModel = {
        return ListViewModel(tableView: tableView)
    }()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observableList()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    @IBAction func addTask(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let bottomSheetVC = storyBoard.instantiateViewController(withIdentifier: "modalVC") as! ModalViewController
        self.present(bottomSheetVC, animated:true, completion:nil)
        
    }
    
    func observableList(){
        
        model.items.asObservable()
            .subscribe(onNext: { [weak self] newVector in
                guard let self = self else { return }
                
                if newVector.isEmpty {
                    self.emptyListView.isHidden = false
                    self.tableView.isHidden = true
                } else {
                    self.emptyListView.isHidden = true
                    self.tableView.isHidden = false
                }
            })
            .disposed(by: disposeBag)

    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        let task = model.items.value[indexPath.row]
        cell.titleLabel.text = task.title
        cell.titleLabel.numberOfLines = 0
        
        let tapEditIcon = UITapGestureRecognizer(target: self, action: #selector(editTaped))
        tapEditIcon.numberOfTapsRequired = 1
        cell.editIcon.addGestureRecognizer(tapEditIcon)
        
        let tapDeleteIcon = UITapGestureRecognizer(target: self, action: #selector(deleteTaped))
        tapDeleteIcon.numberOfTapsRequired = 1
        cell.deleteIcon.addGestureRecognizer(tapDeleteIcon)
        
        
        cell.editIcon.isUserInteractionEnabled = true
        cell.deleteIcon.isUserInteractionEnabled = true
        
        return cell
    }
    
    @objc func editTaped(_ sender: UITapGestureRecognizer) {

        // Converta o ponto tocado na view da imagem para o ponto na tabela
        let location = sender.location(in: tableView) // Substitua "tableView" pelo nome da sua UITableView

        if let indexPath = tableView.indexPathForRow(at: location) {
            // indexPath agora contém o índice da célula clicada
            let items = model.items.value

            guard indexPath.row < items.count else {
                return
            }

            let item = items[indexPath.row]

            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let bottomSheetVC = storyBoard.instantiateViewController(withIdentifier: "modalVC") as! ModalViewController
            bottomSheetVC.passTitle = item.title ?? ""
            bottomSheetVC.passDescription = item.descript ?? ""
            bottomSheetVC.isEdit = true
            bottomSheetVC.id = item.id ?? ""
            self.present(bottomSheetVC, animated:true, completion:nil)
        }
    
    }
    
    @objc func deleteTaped(_ sender: UITapGestureRecognizer) {

        // Converta o ponto tocado na view da imagem para o ponto na tabela
        let location = sender.location(in: tableView) // Substitua "tableView" pelo nome da sua UITableView

        if let indexPath = tableView.indexPathForRow(at: location) {
            // indexPath agora contém o índice da célula clicada
            let items = model.items.value

            guard indexPath.row < items.count else {
                return
            }

            let item = items[indexPath.row]
            
            tableView.beginUpdates()

            model.deleteItem(item: item, tableView: tableView)
            
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = model.items.value[indexPath.row]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailView = storyBoard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        detailView.passTitle = task.title ?? ""
        detailView.passDescription = task.descript ?? ""
        detailView.passData = task.date ?? ""
        navigationController?.pushViewController(detailView, animated: true)
    }
    
}
