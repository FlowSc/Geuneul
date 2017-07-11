//
//  DataCenter.swift
//  Geuneul
//
//  Created by Kang Seongchan on 2017. 7. 11..
//  Copyright © 2017년 Kang Seongchan. All rights reserved.
//

import Foundation

class DataCenter {
    
    static var shared = DataCenter()
    private var settingList:[Any]?
    
    var listCount:Int{
        return settingList?.count ?? 0
    }
    
    private init(){
        loadBundle()
    }
    
    func loadBundle(){
        if let path = Bundle.main.path(forResource: "Setting", ofType: "plist"), let realSettingList = NSArray(contentsOfFile: path) as? [Any]
        {
            self.settingList = realSettingList
        }
        
    }
    
    func titleFor(rowAtIndexPath indexPath:IndexPath) -> String{
        guard let scSettingList = settingList else {
            return ""
        }
        
        let scDic:[String:Any] = scSettingList[indexPath.section] as! [String:Any]
        let rowData = scDic["SectionRow"] as? [Any]
        let myRow = rowData?[indexPath.row] as! [String:String]
        let myRowTitle = myRow["CellTitle"]
        
        return myRowTitle!
        
    }
    
    func rowCount(section:Int)->Int{
        guard let scSettingList = settingList else{
            return 0
        }
        
        let scDic:[String:Any] = scSettingList[section] as! [String:Any]
        let sectionData = scDic["SectionRow"] as? [Any]
        
        return (sectionData?.count)!
    }
    
    func cellTypeFor(indexPath:IndexPath) -> CellType {
        guard let scSettingList = settingList else {
            return .basic
        }
        
        let scDic:[String:Any] = scSettingList[indexPath.section] as! [String:Any]
        let rowData = scDic["SectionRow"] as? [Any]
        let myRow = rowData?[indexPath.row] as! [String:String]
        let myRowType = myRow["CellType"]
        
        return CellType.init(rawValue: myRowType!)!
    }
    
}

enum CellType:String {
    case basic = "SettingCell"
    case switchCell = "SettingSwitchCell"
}
