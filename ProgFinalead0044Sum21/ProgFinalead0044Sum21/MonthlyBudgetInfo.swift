//
//  MonthlyBudgetInfo.swift
//  ProgFinalead0044Sum21
//
//  Created by Elizabeth Dayton on 7/30/21.
//  Copyright © 2021 R.O. Chapman. All rights reserved.
//

import UIKit

class MonthlyBudgetInfo: NSObject, Codable {
    
    var MonthAndYear:String
    var EssentialBudget:String
    var NonEssentialBudget:String
    var Expense:[[String:String]]
    
    enum CodingKeys: String, CodingKey {
        case MonthAndYear
        case EssentialBudget
        case NonEssentialBudget
        case Expense
    }
    
    func encode(in coder: Encoder) throws {
        
        var values = coder.container(keyedBy: CodingKeys.self)
        
        try values.encode(MonthAndYear, forKey: .MonthAndYear)
        try values.encode(EssentialBudget, forKey: .EssentialBudget)
        try values.encode(NonEssentialBudget, forKey: .NonEssentialBudget)
        try values.encode(Expense, forKey: .Expense) 
    }
    
    init(MonthAndYear:String, EssentialBudget:String, NonEssentialBudget:String, Expense:[[String:String]]){
        self.MonthAndYear = MonthAndYear
        self.EssentialBudget = EssentialBudget
        self.NonEssentialBudget = NonEssentialBudget
        self.Expense = Expense
    }
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        MonthAndYear = try values.decode(String.self, forKey: .MonthAndYear)
        EssentialBudget = try values.decode(String.self, forKey: .EssentialBudget)
        NonEssentialBudget = try values.decode(String.self, forKey: .NonEssentialBudget)
        Expense = try values.decode([[String:String]].self, forKey: .Expense)
        
    }
    
//    required init?(coder decoder: NSCoder) {
//        MonthAndYear = decoder.decodeObject(forKey: "MonthAndYear") as! String
//        EssentialBudget = decoder.decodeObject(forKey: "EssentialBudget") as! String
//        NonEssentialBudget = decoder.decodeObject(forKey: "NonEssentialBudget") as! String
//        Expense = decoder.decodeObject(forKey: "Expense") as! [[String:String]]
//    }
    
//    func copy(with zone: NSZone? = nil) -> Any {
//
//        let copy = MonthlyBudgetInfo(MonthAndYear: "MonthAndYear", EssentialBudget: "EssentialBudget", NonEssentialBudget: "NonEssentialBudget", Expense: [["Title":"Amount"]])
//        copy.MonthAndYear = MonthAndYear
//        copy.EssentialBudget = EssentialBudget
//        copy.NonEssentialBudget = NonEssentialBudget
//        copy.Expense = Expense
//
//        return copy

   // }
    
    func decode<T>(_ type: T, from data: Data) throws -> T where T : Decodable {
        
        let monthlyBudgetInfo = try PropertyListDecoder().decode(T.self, from: data)
        return monthlyBudgetInfo
        
    }

}
