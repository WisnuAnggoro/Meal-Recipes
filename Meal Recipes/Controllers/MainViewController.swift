//
//  MainViewController.swift
//  Meal Recipes
//
//  Created by MTMAC18 on 25/06/18.
//  Copyright © 2018 Wisnu Anggoro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {
    
    var categories : [Category] = []
    let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
    var jsonData : JSON = JSON.null;

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getCategories()
        let URL = "https://www.themealdb.com/api/json/v1/1/categories.php"
////        let URL = "https://www.themealdb.com/api/json/v1/1/"
//
//        let parameters : [String] = ["categories.php"]
//
//        Alamofire.request(URL).responseJSON { (responseData) -> Void in
//            if((responseData.result.value) != nil) {
//                let swiftyJsonVar = JSON(responseData.result.value!)
//                print(swiftyJsonVar)
//            }
//        }
//
//        let bo = doRequest(param: "categories.php")
//        if(bo){
//            print(jsonData.rawString())
//            if let categoriesArray = jsonData["categories"].array {
//                print(categoriesArray[0])
//            }
//        }
        
        getRequest(url: URL)
    }
    
    func doRequest(param : String) -> Bool {
        
        let url = baseUrl + param;
        var returnValue = true
        
        Alamofire.request(url).responseJSON { response in
            if(response.result.isSuccess) {
                self.jsonData = JSON(response.result.value!)
                print(self.jsonData.rawString())
            }
            else {
                self.jsonData = JSON.null
                returnValue = false
            }
        }
        
        return returnValue
    }
    
//    func getRequest(param : String) -> JSON {
//
//        var tempJson : JSON = [];
//        let url = baseUrl + param;
//
//        Alamofire.request(url).responseJSON { response in
//            if(response.result.isSuccess) {
//                tempJson = JSON(response.result.value!)
//            }
//            else {
//                tempJson = JSON.null
//            }
//        }
//
//        return tempJson
//    }

    
    func getCategories() {
        
//        let url = baseUrl + "categories.php";
//
//        Alamofire.request(url).responseJSON { response in
//            if(response.result.isSuccess) {
//                let json: JSON = JSON(response.result.value!)
//                var counter = 0
//                if let cats = json["categories"].array {
//                    for obj in cats {
//                        print(counter)
//                        print(obj)
//                        counter+=1
//                    }
//                }
//            }
//            else {
//                self.jsonData = JSON.null
//            }
//        }
        
//        let url = baseUrl + "categories.php"
//        let json = getRequest(url: url)
//        if(json == JSON.null) {
//            return
//        }
//
//        print(json.rawString()!)
//
//        if let jsonCategories = json["categories"].array {
//            for category in jsonCategories {
//                var c = Category()
//                c.Id = category["idCategory"].rawString()!
//                c.Name = category["strCategory"].rawString()!
//                c.Thumb = category["strCategoryThumb"].rawString()!
//                c.Description = category["strCategoryDescription"].rawString()!
//                categories.append(c)
////                print(c.Name)
//            }
//        }
    }
    
    func getRequest(url: String) {
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess {
                self.jsonData = JSON(response.result.value!)
                print(self.jsonData.rawString()!)
                
                        if let jsonCategories = self.jsonData["categories"].array {
                            for category in jsonCategories {
                                let c = Category()
                                c.Id = category["idCategory"].rawString()!
                                c.Name = category["strCategory"].rawString()!
                                c.Thumb = category["strCategoryThumb"].rawString()!
                                c.Description = category["strCategoryDescription"].rawString()!
                                self.categories.append(c)
                                print(c.Name)
                            }
                        }
                
            }
            else {
            }
        }
    }
    
    // MARK: - Event Methods
    @IBAction func onCategoriesTap(_ sender: UIButton) {
//        let vc = ListTableViewController()
//        vc.categories = categories
//        performSegue(withIdentifier: "goToListTable", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToListTable") {
            let vc = segue.destination as! ListTableViewController
            vc.categories = categories
        }
    }
    
}

