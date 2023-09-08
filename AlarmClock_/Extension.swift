//
//  Extension.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/09/08.
//

import UIKit

extension UIImage {
    func resizeImageTo(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        // 비트맵 그래픽 배경에 이미지 다시 그리기
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        // 현재 비트맵 그래픽 배경에서 이미지 가져오기
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        // 비트맵 환경 제거
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
