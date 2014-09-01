<<<<<<< HEAD
//
//  OpiniaoViewController.swift
//  CocoaQuiz
//
//  Created by Swift Dojo on 16/08/14.
//  Copyright (c) 2014 Swift Dojo. All rights reserved.
//

import UIKit
import CoreData

class OpiniaoViewController: UIViewController, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    
    // cria o objeto MOC atraves dele podera acessar os dados do DB. Ele é responsável por gerenciae seus ciclos de vida e os objetos criados e retornados.
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    
    @IBOutlet var txtPrimeiroNome: UITextField!
    @IBOutlet var txtSobreNome: UITextField!
    @IBOutlet var sldNota: UISlider!
    @IBOutlet var lblValorNota: UILabel!
    @IBOutlet var btnSalvarAvaliacao: UIBarButtonItem!
    
    var opiniao: Opiniao? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if opiniao != nil {
            txtPrimeiroNome.text = opiniao?.primeiroNome
            txtSobreNome.text = opiniao?.sobreNome
            sldNota.value = (opiniao?.nota)!.floatValue
            //sldNota.value =
        }

        // Do any additional setup after loading the view.
        txtPrimeiroNome.delegate = self
        txtSobreNome.delegate = self
        lblValorNota.text = "Nota: \(sldNota.value)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // action utilizada para limitar as notas com valores inteiros.
    @IBAction func definirNotaInteger(sender: UISlider) {
        var sliderValue: Int
        sliderValue = lroundf(sldNota.value)
        sldNota.value =  Float(sliderValue)
        lblValorNota.text = "Nota: \(sldNota.value)"
    }
    
    @IBAction func salvarAvaliacao(sender: AnyObject) {
        if opiniao != nil {
            
            editarOpiniao()
        }
        else {
            inserirNovaOpiniao()
        }
        
        
        navigationController.popViewControllerAnimated(true)
        
    }
    
    func inserirNovaOpiniao() {
        let entityDescripition = NSEntityDescription.entityForName("Opiniao", inManagedObjectContext: managedObjectContext)
        let opiniao = Opiniao(entity: entityDescripition, insertIntoManagedObjectContext: managedObjectContext)
        
        opiniao.primeiroNome = txtPrimeiroNome.text
        opiniao.sobreNome = txtSobreNome.text
        opiniao.nota = sldNota.value
        opiniao.timeStamp = NSDate.date()
        //println(opiniao)
        self.managedObjectContext?.save(nil)
        
    }
    
    func editarOpiniao() {
        opiniao?.primeiroNome = txtPrimeiroNome.text
        opiniao?.sobreNome = txtSobreNome.text
        opiniao?.nota = sldNota.value
        opiniao?.timeStamp = NSDate.date()
        managedObjectContext?.save(nil)
    }
    
    

}
=======
//
//  OpiniaoViewController.swift
//  CocoaQuiz
//
//  Created by Swift Dojo on 16/08/14.
//  Copyright (c) 2014 Swift Dojo. All rights reserved.
//

import UIKit

class OpiniaoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
>>>>>>> 8e68123a3bf8f4a65bf9310d16be20a5934ee8d3
