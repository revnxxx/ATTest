//
//  DataManager.swift
//  ATTest
//
//  Created by Revn Revn on 09.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataManager {
    
    private let posts = "http://jsonplaceholder.typicode.com/posts/"
    private let NOTIFICATION_POST = "postUpdate"
    private let comments = "http://jsonplaceholder.typicode.com/comments/"
    private let NOTIFICATION_COMMENT = "commentUpdate"
    private let users = "http://jsonplaceholder.typicode.com/users/"
    private let NOTIFICATION_USER = "userUpdate"
    private let photos = "http://jsonplaceholder.typicode.com/photos/"
    private let NOTIFICATION_PHOTO = "photoUpdate"
    private let todos = "http://jsonplaceholder.typicode.com/todos/"
    
    private var userDataArray = [UserDto]()
    
    func getPost(postId: Int) {
        let urlPost = posts + "\(postId)"
        makeRequest(url: urlPost, version: 1)
    }
    
    func getComment(commentId: Int) {
        let urlComment = comments + "\(commentId)"
        makeRequest(url: urlComment, version: 2)
    }
    
    func getUsers() {
        for index in 1...5 {
            let urlUser = users + "\(index)"
            makeRequest(url: urlUser, version: 3)
        }
    }
    
    func getPhoto() {
        let urlPhoto = photos + "3"
        makeRequest(url: urlPhoto, version: 4)
    }
    
    private func makeRequest(url: String, version: Int) {
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                switch version {
                case 1 :
                    self.requstPost(json: json)
                case 2:
                    self.requstComment(json: json)
                case 3 :
                    self.requestUser(json: json)
                case 4 :
                   self.requestPhoto(json: json)
                default:
                    print ("Chose default")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func requstPost(json: JSON) {
        let postDto = PostDto(userId: json["userId"].int!, id: json["id"].int!, titel: json["title"].string!, body: json["body"].string!)
        let post:[String: PostDto] = ["post": postDto]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.NOTIFICATION_POST), object: nil, userInfo: post)
    }
    
    private func requstComment(json: JSON) {
        let commentDto = CommentDto(postId: json["postId"].int!, id: json["id"].int!, name: json["name"].string!, email: json["email"].string!, body: json["body"].string!)
        let comment:[String: CommentDto] = ["comment": commentDto]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.NOTIFICATION_COMMENT), object: nil, userInfo: comment)
    }
    
    private func requestUser(json: JSON) {
        let userDto = UserDto(id: json["id"].int!, name: json["name"].string!, username: json["username"].string!, email: json["email"].string!, street: json["address"]["street"].string!, suite: json["address"]["suite"].string!, city: json["address"]["city"].string!, zipcode: json["address"]["zipcode"].string!, lat: json["address"]["geo"]["lat"].string!, lng: json["address"]["geo"]["lng"].string!, phone: json["phone"].string!, website: json["website"].string!, companyName: json["company"]["name"].string!, catchPhrase: json["company"]["catchPhrase"].string!, bs: json["company"]["bs"].string!)
        self.userDataArray.append(userDto)
        if self.userDataArray.count == 5 {
            let usersArr:[String: [UserDto]] = ["users": self.userDataArray]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.NOTIFICATION_USER), object: nil, userInfo: usersArr)
        }
    }
    
    private func requestPhoto(json: JSON) {
        let photoDto = PhotoDto(albumId: json["albumId"].int!, id: json["id"].int!, title: json["title"].string!, url: json["url"].string!, thumbnailUrl: json["thumbnailUrl"].string!)
        let photo:[String: PhotoDto] = ["photo": photoDto]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.NOTIFICATION_PHOTO), object: nil, userInfo: photo)
    }
}
