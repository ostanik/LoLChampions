//
//  OKChampionDetailViewController.swift
//  LoLChampions
//
//  Created by Alan Ostanik on 1/9/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//
import CoreData
import Kingfisher

/// Classe Controller da tela de Informações do campeão.
class OKChampionDetailViewController: UITableViewController {
    var fetchedController = NSFetchedResultsController()
    
    override func viewWillAppear(animated: Bool) {
        let predicate = NSPredicate(format: "identifier = %@", selectedItem)
        fetchedController = OKCoreDataManager.sharedInstance.fetchRegistersFromEntity("ChampInfo",
            predicate: predicate,
            sortDescriptor: [NSSortDescriptor(key: "identifier", ascending:true)]
        )
    }
    
    override func viewDidLoad() {
        self.navigationItem.title = selectedName as String
    }
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return 5
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            let record: ChampInfo = self.fetchedController.fetchedObjects![0] as! ChampInfo
            
            if(indexPath.row == 0){
                let cell = tableView.dequeueReusableCellWithIdentifier("\(indexPath.row)", forIndexPath: indexPath) as! OKPhotoCell
                cell.bind(record)
                return cell;
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("\(indexPath.row)", forIndexPath: indexPath) as! OKStatisticsCell
                cell.bind(record, kind: indexPath.row)
                return cell
            }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 720;
        }
        return 90;
    }
    
}
