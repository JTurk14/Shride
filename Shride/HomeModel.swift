//
//  HomeModel.swift
//  Shride
//
//  Created by Joel Turk on 6/18/18.
//  Copyright © 2018 Shride. All rights reserved.
//

import Foundation

protocol HomeModelProtocol: class{
    func carResultFill(items: NSArray)
}

class HomeModel: NSObject,URLSessionDataDelegate {
    
    weak var delegate: HomeModelProtocol!
    
    var data = Data()
    
    let urlPath: String = "http://localhost:8000/rentalRequest.php"
    
    func carDBQuery(){
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url)
        { (data, response, error) in
            if error != nil {
                print("Failed to get data")
            } else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
        }
    
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as Error{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let cars = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let car = CarDBModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let owner = jsonElement["Owner"] as? String,
                let make = jsonElement["Make"] as? String,
                let model = jsonElement["Model"] as? String,
                let address = jsonElement["Address"] as? String
            {
                
                car.owner = owner
                car.address = address
                car.make = make
                car.model = model
                
            }
            
            cars.add(car)
            
        }
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.carResultFill(items: cars)
        })
    }
}
