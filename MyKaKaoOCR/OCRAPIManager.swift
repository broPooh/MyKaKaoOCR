//
//  OCRApiManager.swift
//  MyKaKaoOCR
//
//  Created by bro on 2022/05/10.
//

import UIKit.UIImage
import Alamofire
import SwiftyJSON

class OCRAPIManager {
    static let shared = OCRAPIManager()
    
    func fetchOcrData(image: UIImage, result: @escaping (Int, JSON) -> () ) {
        let header: HTTPHeaders = [
            "Authorization": APIKey.KAKAO_KEY,
            "Content-Type" : "multipart/form-data"
        ]
        
        //UIImage를 바이너리 타입으로 변환하기
        guard let imageData = image.pngData() else { return }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image")
        }, to: EndPoint.kakaoOCRURL, headers: header)
            .validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let code = response.response?.statusCode ?? 500
                
                result(code, json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
