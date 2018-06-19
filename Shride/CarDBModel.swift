//
//  CarDBModel.swift
//  Shride
//
//  Created by Joel Turk on 6/18/18.
//  Copyright © 2018 Shride. All rights reserved.
//

import Foundation

class CarDBModel: NSObject{
    
    var owner: String?
    var make: String?
    var model: String?
    var address: String?
    
    override init(){
        
    }
    init(owner: String, make: String, model: String, address: String){
        self.owner = owner
        self.make = make
        self.model = model
        self.address = address
    }
    
    override var description: String{
        return "Owner: \(owner)\tMake: \(make)\tModel: \(model)\tAddress: \(address)"
    }
}
