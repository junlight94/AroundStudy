//
//  CustomFloatingPanel.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/14.
//

import Foundation
import FloatingPanel

class CustomFloatingPanelLayout: FloatingPanelLayout {
    /// 절반으로 올라올 시, 하단 여백 커스텀 설정(디폴트: 150)
    var layoutBottomInset: CGFloat?
    /// 패널 포지션 설정
    var position: FloatingPanelPosition = .bottom
    /// 패널 초기상태 설정
    var initialState: FloatingPanelState = .tip
    
    /// 플로팅 패널 제약조건 설정
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: UIScreen.main.bounds.height / 2, edge: .top, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: layoutBottomInset ?? 150.0, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
    
    /**
     * @플로팅패널 백그라운드 딤처리 알파설정
     * @creator : coder3306
     * @Return : 설정된 딤 배율 반환
     */
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        switch state {
            case .full, .half: return 0.5
        default: return 0.0
        }
    }
}
