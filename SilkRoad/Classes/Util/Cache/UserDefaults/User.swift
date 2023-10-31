//
//  User.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/19.
//

import Foundation
import SwiftyJSON

/*
 *第一次使用创建一个用户信息
 *该用户信息仅保存在本地
 */
func createUser() -> String  {
    let jsonString = "{\"username\":\"小王子\",\"sex\":\"女\",\"age\":18,\"birth\":\"9月11日\",\"address\":\"湖南-株洲-天元区\"}"
    return jsonString
}

//保存用户信息在本地
func saveUser<T: Any>(_ user: T) {
    UserDefaults.standard.setValue(user, forKey: "user")
}

func getJSONForUser() -> JSON? {
    guard let jsonString = UserDefaults.standard.value(forKey: "user") as? String else { return nil }
    let json = JSON(parseJSON: jsonString)
    return json
}

func getUsername() -> String? {
    guard let json = getJSONForUser() else { return nil }
    return json["username"].stringValue
}

func getSex() -> String? {
    guard let json = getJSONForUser() else { return nil }
    return json["sex"].stringValue
}

func getAge() -> Int? {
    guard let json = getJSONForUser() else { return nil }
    return json["age"].intValue
}

func getBirth() -> String? {
    guard let json = getJSONForUser() else { return nil }
    return json["birth"].stringValue
}

func getAddress() -> String? {
    guard let json = getJSONForUser() else { return nil }
    return json["address"].stringValue
}
