//
//  Meal.swift
//  Recipes
//
//  Created by Alex on 09.11.2017.
//  Copyright © 2017 Alex. All rights reserved.
//
import Foundation
import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            if #available(iOS 10.0, *) {
                os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            } else {
                // Fallback on earlier versions
            }
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
        
    }
    
        //MARK: Свойства
        var name: String
        var photo: UIImage?
        var rating: Int
    
        //MARK: Archiving Paths
    
        static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
        //MARK: Types
        struct PropertyKey {
            static let name = "name"
            static let photo = "photo"
            static let rating = "rating"
        }
        
        //MARK: Инициализация
        init? (name: String, photo: UIImage?, rating: Int) {
            //MARK: Ошибка если нет рейтинга
            guard !name.isEmpty else {
                return nil
            }
            guard (rating >= 0) && (rating <= 5) else {
                return nil
            }
            self.name = name
            self.photo = photo
            self.rating = rating
        }
    //MARK: NSCoding

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
}
