//
//  PHPhotoLibrary+Rx.swift
//  Combinestagram
//
//  Created by Karim Ebrahem on 10/17/18.
//  Copyright © 2018 Underplot ltd. All rights reserved.
//

import Foundation
import Photos
import RxSwift

extension PHPhotoLibrary {
    static var authorized: Observable<Bool> {
        return Observable.create { observer in
            DispatchQueue.main.async {
                if authorizationStatus() == .authorized {
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    observer.onNext(false)
                    
                    requestAuthorization({ newStatus in
                        observer.onNext(newStatus == .authorized)
                        observer.onCompleted()
                    })
                }
            }
            
            return Disposables.create()
        }
    }
}
