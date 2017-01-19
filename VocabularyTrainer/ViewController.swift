//
//  ViewController.swift
//  VocabularyTrainer
//
//  Created by MIGUEL MOLDES on 9/1/17.
//  Copyright © 2017 MIGUEL MOLDES. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var operations : [REDFetchTranslationOperation]?
    var operationsQueue : REDOperationsQueue?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        testOperations()

    }

    func testOperations(){
        let firstLanguage = "de"
        let secondLanguage = "en"
        let wordTyped = "laufen"
        var wordFirstLanguage : String = ""

        operationsQueue = REDOperationsQueue()
        let fetchOperation1 = REDFetchTranslationOperation(word:wordTyped, defaultLanguage: firstLanguage, fallbackLanguage: secondLanguage)!
        let fetchOperation2 = REDFetchTranslationOperation(word:wordTyped, defaultLanguage: secondLanguage, fallbackLanguage: firstLanguage)!
        fetchOperation2.successDependencies = [fetchOperation1]
        fetchOperation2.dependencies = [fetchOperation1]

        let fetchOperation3 = REDSyncTestOperation()!
        fetchOperation3.dependencies = [fetchOperation2]
        operationsQueue?.completionBlock = {
            self.operationsQueue = nil
        }
        operationsQueue?.addOperations(operations: [fetchOperation1, fetchOperation2, fetchOperation3])

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
