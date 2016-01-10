//
//  OKCoreDataManager.swift
//  LoLChampions
//
//  Created by Alan Ostanik on 1/9/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

import CoreData

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

/// Classe responsavel por fazer o gerenciamento com o CoreData
class OKCoreDataManager: NSObject {
    
    let managedContext = appDelegate.managedObjectContext
    /// Construtor singleton
    static let sharedInstance = OKCoreDataManager()
    
    /**
     Função publica responsavel por remover todos os dados das entidades
     */
    func removeAllData (){
        self.remove("Champions")
        self.remove("ChampInfo")
    }
    
    /**
     Função privada que executa a remoção dos dados.
     
     - parameter entity: nome da entidade que terá os itens excluidos.
     */
    private func remove(entity: NSString) {
        let sort = [NSSortDescriptor(key: "identifier", ascending: true)]
        let fetchedController = self.fetchRegistersFromEntity(entity,
            predicate: nil,
            sortDescriptor: sort
        )
        
        if let _ = fetchedController.fetchedObjects {
            do {
                for obj: AnyObject in fetchedController.fetchedObjects! {
                    managedContext.deleteObject(obj as! NSManagedObject);
                }
                try managedContext.save()
            } catch let error as NSError {
                print("Não foi possivel deletar os dados \(error), \(error.userInfo)")
            }
        }
    }
    
    /**
     Função responsavel por realizar a consulta de dados da entidade
     
     - parameter entityName: String com o nome da entidade que deseja realizar a consulta
     - parameter predicate:  Predicado (filtro) para a consulta (caso exista, caso contrario passar nil)
     
     - returns: retorna um NSManagedObjects com os dados da consulta.
     */
    func fetchRegistersFromEntity(entityName:NSString, predicate:NSPredicate?, sortDescriptor:[NSSortDescriptor]) -> NSFetchedResultsController{
        let fetchRequest = NSFetchRequest(entityName: entityName as String);
        fetchRequest.sortDescriptors = sortDescriptor
        if let pr = predicate {
            fetchRequest.predicate = pr
        }
        
        let fetchedController = NSFetchedResultsController.init(fetchRequest: fetchRequest, managedObjectContext: self.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedController.performFetch()
            return fetchedController
        } catch let error as NSError {
            print("Não foi possivel recuperar os dados \(error), \(error.userInfo)")
            return fetchedController
        }
    }
    
    /**
     Responsavel por salvar um novo campeão na entidade "Champions"
     
     - parameter dic: Dicionário com os dados do campeão
     */
    func saveChampion(dic:NSDictionary) {
        var handlerObjects = [NSManagedObject]()
        let entity = NSEntityDescription.entityForName("Champions", inManagedObjectContext: managedContext)
        let champion = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        champion.setValue(dic.objectForKey("id"), forKey: "identifier")
        champion.setValue(dic.objectForKey("title"), forKey: "title")
        champion.setValue(dic.objectForKey("name"), forKey: "name")
        champion.setValue(dic.objectForKey("key"), forKey: "key")
        
        let name = (dic.objectForKey("name") as! String).stringByReplacingOccurrencesOfString(" ", withString: "")
        let path = (appDelegate.config?.objectForKey("iconPath") as! NSString).stringByAppendingString("\(name).png")
        
        
        champion.setValue(path, forKey: "iconPath")
        
        do {
            try managedContext.save()
            handlerObjects.append(champion)
        } catch let error as NSError {
            print("Não foi possivel salvar os dados \(error), \(error.userInfo)")
        }
    }
    
    /**
     Função responsavel por salvar as informações do campeão.
     
     - parameter dic:     Dicionário com as infos do campeão
     - parameter identifier: Identificador do campeão.
     */
    func saveChampInfo(dic: NSDictionary, identifier: NSNumber, champName:NSString){
        var handlerObjects = [NSManagedObject]()
        let entity = NSEntityDescription.entityForName("ChampInfo", inManagedObjectContext: managedContext)
        let info = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        info.setValue(identifier, forKey: "identifier")
        info.setValue(dic.objectForKey("attack"), forKey: "attack")
        info.setValue(dic.objectForKey("defense"), forKey: "defense")
        info.setValue(dic.objectForKey("difficulty"), forKey: "difficulty")
        info.setValue(dic.objectForKey("magic"), forKey: "magic")
        
        let name = champName.stringByReplacingOccurrencesOfString(" ", withString: "")
        let path = (appDelegate.config?.objectForKey("splashPath") as! NSString).stringByAppendingString("\(name)_0.jpg")
        
        info.setValue(path, forKey: "splashPath")
        do {
            try managedContext.save()
            handlerObjects.append(info)
        } catch let error as NSError {
            print("Não foi possivel salvar os dados \(error), \(error.userInfo)")
        }
    }
}
