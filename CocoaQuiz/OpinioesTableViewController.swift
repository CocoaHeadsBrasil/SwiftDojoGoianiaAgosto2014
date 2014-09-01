<<<<<<< HEAD
//
//  OpinioesTableViewController.swift
//  CocoaQuiz
//
//  Created by Swift Dojo on 16/08/14.
//  Copyright (c) 2014 Swift Dojo. All rights reserved.
//

import UIKit
import CoreData


class OpinioesTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    



    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
*/

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "editarSegue" { //adicionarSegue
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            
            var opiniao:Opiniao = fetchedResultController.objectAtIndexPath(indexPath) as Opiniao
            (segue.destinationViewController as OpiniaoViewController).opiniao = opiniao
        }
        
    }
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Opiniao")
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return fetchedResultController.sections.count
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections[section].numberOfObjects
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var opiniao = fetchedResultController.objectAtIndexPath(indexPath) as Opiniao
        
        cell.textLabel.text = (opiniao.valueForKey("primeiroNome") as String) + " " + (opiniao.valueForKey("sobreNome") as String)
        
        var nota = opiniao.valueForKey("nota") as Float
        if (nota < 4) {// Nota menor que 4
            cell.detailTextLabel.text = "😡 \(nota)"
        }
        else if (nota > 6) {// Nota maior que 6
            cell.detailTextLabel.text = "😄 \(nota)"
        }
        else { // Nota entre 4 e 6
            cell.detailTextLabel.text = "😒 \(nota)"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as NSManagedObject
        managedObjectContext?.deleteObject(managedObject)
        managedObjectContext?.save(nil)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        tableView.reloadData()
    }


}
=======
//
//  OpinioesTableViewController.swift
//  CocoaQuiz
//
//  Created by Swift Dojo on 16/08/14.
//  Copyright (c) 2014 Swift Dojo. All rights reserved.
//

import UIKit
import CoreData

class OpinioesTableViewController: UITableViewController {
    
    var opinioes = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var appDelegate = (UIApplication.sharedApplication().delegate) as AppDelegate
        
        var context = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Opiniao")
        opinioes = context.executeFetchRequest(request, error:nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return opinioes.count
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        var opiniao = opinioes[indexPath.row] as NSManagedObject
        cell.textLabel.text = opiniao.valueForKey("primeiroNome") as String
        
        var nota = opiniao.valueForKey("nota") as Float
        if (nota < 4) {// Nota menor que 4
            cell.detailTextLabel.text = "😡"
        }
        else if (nota > 6) {// Nota maior que 6
            cell.detailTextLabel.text = "😄"
        }
        else { // Nota entre 4 e 6
            cell.detailTextLabel.text = "😒"
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
>>>>>>> 8e68123a3bf8f4a65bf9310d16be20a5934ee8d3
