
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "editarSegue" { //adicionarSegue
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            
            var opiniao:Opiniao = fetchedResultController.objectAtIndexPath(indexPath!) as Opiniao
            (segue.destinationViewController as OpiniaoViewController).opiniao = opiniao
        }
        
    }
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Opiniao")
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultController.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var opiniao = fetchedResultController.objectAtIndexPath(indexPath) as Opiniao
        
        cell.textLabel?.text = (opiniao.valueForKey("primeiroNome") as String) + " " + (opiniao.valueForKey("sobreNome") as String)
        
        var nota = opiniao.valueForKey("nota") as Float
        if (nota < 4) {// Nota menor que 4
            cell.detailTextLabel?.text = "😡 \(nota)"
        }
        else if (nota > 6) {// Nota maior que 6
            cell.detailTextLabel?.text = "😄 \(nota)"
        }
        else { // Nota entre 4 e 6
            cell.detailTextLabel?.text = "😒 \(nota)"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: (NSIndexPath!)) {
        let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as NSManagedObject
        managedObjectContext?.deleteObject(managedObject)
        managedObjectContext?.save(nil)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        tableView.reloadData()
    }


}