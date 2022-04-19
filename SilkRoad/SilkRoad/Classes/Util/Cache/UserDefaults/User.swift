//
//  User.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/19.
//

import Foundation

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
