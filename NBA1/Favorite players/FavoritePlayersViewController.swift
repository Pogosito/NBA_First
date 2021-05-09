//
//  FavoritePlayersViewController.swift
//  NBA1
//
//  Created by Погос  on 08.12.2019.
//  Copyright © 2019 Погос . All rights reserved.
//

import UIKit
import CoreData

class FavoritePlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var names: [NSManagedObject] = []
     
    var cellId = "CellId"
    
    var plyersTable: UITableView = {
        var viewTable = UITableView()
        viewTable.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        viewTable.separatorColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return viewTable
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Favorite Players", image: UIImage(named: "Love"), tag: 1)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite Players"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(q))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addPlayer))
        inputPlayersTable()
        view.addSubview(plyersTable)
    }
    
    @objc func q() {
        startEditing()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Player")
        do {
            names = try managedContext.fetch(fetchRequest)
        } catch let err as NSError {
            print("Sorry your fetch items failed", err)
        }
    }
    
    func inputPlayersTable() {
        plyersTable.frame = self.view.frame
        plyersTable.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        plyersTable.delegate = self
        plyersTable.dataSource = self
    }
    
    @objc func addPlayer(_ sender: Any) {
        let alertController = UIAlertController(title: "Add your favorite player", message: "Please fill in the textfield player name", preferredStyle: .alert)
        let saveAction  = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textField = alertController.textFields?.first, let itemToAdd = textField.text else { return }
            if ((textField.text)! == "") {
                self.addPlayer(sender)
                return
            }
            self.save(itemToAdd)
            self.plyersTable.reloadData()
        }
    
        
        let cancealAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancealAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func save(_ plyerName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Player", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(plyerName, forKey: "playerName")
        
        do {
            try managedContext.save()
            names.append(item)
        } catch let err as NSError {
            print("Sorry your player not safed", err)
        }
    }
    
    func saveAll() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Player", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
       // item.setValue(forKey: "playerName")
        
        do {
            try managedContext.save()
            names.append(item)
        } catch let err as NSError {
            print("Sorry your player not safed", err)
        }
    }
    
    func startEditing() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
        if (plyersTable.isEditing == false) {
            plyersTable.isEditing = true
        } else {
             plyersTable.isEditing = false
             plyersTable.reloadData()
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = names[sourceIndexPath.row]
        names.remove(at: sourceIndexPath.row)
        names.insert(itemToMove, at: destinationIndexPath.row)
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.textLabel?.font = UIFont(name: "AvenirNextCondensed-Bold", size: 30)
        let item = names[indexPath.row]
        cell.textLabel?.text = item.value(forKeyPath: "playerName") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //names.remove(at: indexPath.row)
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext

            managedContext.delete(self.names[indexPath.row])

            do {
                try managedContext.save()
                self.names.remove(at: indexPath.row)
                self.plyersTable.reloadData()
            } catch {

            }

        }
    }
}
