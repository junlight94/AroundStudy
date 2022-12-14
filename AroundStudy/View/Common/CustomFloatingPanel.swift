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
    private var defaultBottomInset: CGFloat = 150.0
    var bottomLayoutInset: CGFloat {
        get {
            return defaultBottomInset
        } set {
            defaultBottomInset = newValue
        }
    }
    /// 패널 포지션 설정
    var position: FloatingPanelPosition = .bottom
    /// 패널 초기상태 설정
    var initialState: FloatingPanelState = .tip
    /// 팝업 노출 높이 플래그 설정
    var setHalfOnly = false
    /// 절반 노출 시 , 노출높이 조절용 프로퍼티
    var halfHeight = UIScreen.main.bounds.height / 2
    /// 플로팅 패널 제약조건 설정
    public var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        get {
            return setAnchor(defaultBottomInset)
        }
    }
    
    /**
     * @플로팅패널 백그라운드 딤처리 알파설정
     * @creator : coder3306
     * @Return : 설정된 딤 배율 반환
     */
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        switch state {
            case .full: return 0.6
            case .half: return 0.4
            case .tip: return 0.1
        default: return 0.0
        }
    }
    
    /**
     * @플로팅패널 앵커 설정
     * @creator : coder3306
     * @param absInset : 하단 높이 제약조건 설정
     * @Return : 설정된 앵커 반환
     */
    private func setAnchor(_ absInset: CGFloat) -> [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        var anchor: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
            .half: FloatingPanelLayoutAnchor(absoluteInset: halfHeight, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: absInset, edge: .bottom, referenceGuide: .safeArea)
        ]
        if !setHalfOnly {
            anchor.updateValue(FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea), forKey: .full)
        }
        return anchor
    }
    
}
