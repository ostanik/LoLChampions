//
//  OKChampionsViewController.swift
//  LoLChampions
//
//  Created by Alan Ostanik on 1/9/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//
import CoreData
import Kingfisher
import DGElasticPullToRefresh

/// Variavel utilizada para salvar o ID do campeão selecionado (necessário na tela de info)
var selectedItem = NSNumber();
/// Variavel utilizada para salvar o nome do campeão selecionado (necessário na tela de info)
var selectedName = NSString();

class OKChampionsViewController: UITableViewController {
    var fetchedController = NSFetchedResultsController()
    
    /**
     Função responsavel por pegar a listagem de campeões da API e recarregar o tableView
     */
    func getListChampions() {
        OKNetwork().getChampions({ () -> Void in
            
            self.fetchedController = OKCoreDataManager.sharedInstance.fetchRegistersFromEntity("Champions",
                predicate: nil,
                sortDescriptor: [NSSortDescriptor(key: "name", ascending:true)]
            )
            self.tableView.reloadData();
            self.tableView.dg_stopLoading()
            
            }) { (error: NSError!) -> Void in
                print("Não foi possivel fazer a requisição ao servidor \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Cria a loadingView para atualizar a lista quando o usuario puxar a tableView.
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.whiteColor()
        /**
        *  Função que será chamada ao atualizar a tableView. Ela descarrega os dados da mesma e realiza uma nova requisição para a API
        *  Atualizando por sua vez as entidades do CoreData.
        */
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            self?.fetchedController = NSFetchedResultsController();
            self?.tableView.reloadData()
            self?.getListChampions()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor.blackColor())
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
        self.fetchedController = OKCoreDataManager.sharedInstance.fetchRegistersFromEntity("Champions",
            predicate: nil,
            sortDescriptor: [NSSortDescriptor(key: "name", ascending:true)]
        )
        if (fetchedController.fetchedObjects!.count == 0) {
            self.getListChampions()
        }
    }
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            // Testa se existe dados, para carregar a celula de "loading"
            if let _ = fetchedController.fetchedObjects {
                return fetchedController.fetchedObjects!.count
            } else {
                return 1
                
            }
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            if let _ = fetchedController.fetchedObjects {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("ChampCell", forIndexPath: indexPath) as! OKChampionCell
                let champion:Champions = self.fetchedController.objectAtIndexPath(indexPath) as! Champions
                cell.bind(champion)
                
                return cell
                
            } else {
                //Carrega a celula de loading, ja que não existem dados para ser exibidos
                let cell = tableView.dequeueReusableCellWithIdentifier("loading")
                return cell!;
            }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let view: OKChampionDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Detail") as! OKChampionDetailViewController
        
        let champion:Champions = self.fetchedController.objectAtIndexPath(indexPath) as! Champions
        selectedItem = champion.identifier!
        selectedName = champion.name!
        
        view.modalTransitionStyle = UIModalTransitionStyle.CoverVertical;
        self.navigationController?.pushViewController(view, animated: true)
        
    }
}
