//
// Created by MIGUEL MOLDES on 11/1/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation

class REDFetchTranslationOperation : MMOperationProtocol {

    var operation: Operation

    let word : String
    let defaultLanguage : String
    let fallbackLanguage : String
    var translation : String?

    var dependencies = [MMOperationProtocol]()
    var successDependencies = [MMOperationProtocol]()

    init?(word:String, defaultLanguage:String, fallbackLanguage:String){
        self.word = word
        self.defaultLanguage = defaultLanguage
        self.fallbackLanguage = fallbackLanguage
        self.operation = MMAsynchronousOperation()
        (self.operation as! MMAsynchronousOperation).delegate = self
    }

    func execute() {
        let url = URL(string:"http://api.ultralingua.com/api/definitions/\(self.defaultLanguage)/\(self.fallbackLanguage)/\(self.word)")!
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard error == nil else {
                print("error")
                self.operation.cancel()
                (self.operation as! MMAsynchronousOperation).finishOperation()
                return
            }

            guard let data = data else {
                print("no data")
                self.operation.cancel()
                (self.operation as! MMAsynchronousOperation).finishOperation()
                return
            }

            _ = try? JSONSerialization.jsonObject(with: data, options:[])

            print("json")
            (self.operation as! MMAsynchronousOperation).finishOperation()
        }

        task.resume()
    }


}
