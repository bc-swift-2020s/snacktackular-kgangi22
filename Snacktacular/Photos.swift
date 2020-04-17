//
//  Photos.swift
//  Snacktacular
//
//  Created by Kyle Gangi on 4/17/20.
//  Copyright © 2020 John Gallaugher. All rights reserved.
//

import Foundation
import Firebase


class Photos {
    var photoArray: [Photo] = []
    var db: Firestore!
    
    init(){
        db = Firestore.firestore()
        
    }
    
}


