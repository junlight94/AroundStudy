//
//  CustomCalendarCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/14.
//

import UIKit
import FSCalendar

enum SelectionType : Int {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}

class CalendarCell: FSCalendarCell {
    /// 시작,종료일 레이어
    var selectionLayer: CAShapeLayer?
    /// 시작,종료일 사이 연결부 레이어
    var connectionLayer: CAShapeLayer?

    var selectionType: SelectionType = .none {
        didSet {
            if selectionType == .none {
                self.selectionLayer?.isHidden = true
                self.connectionLayer?.isHidden = true
                return
            }
            setNeedsLayout()
        }
    }

    /**
     * @커스텀 셀 초기화
     * @creator : coder3306
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    /**
     * @필요 시 초기화 설정
     * @creator : coder3306
     */
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    /**
     * @직전, 다음달 미리보기 설정
     * @creator : coder3306
     */
    override func configureAppearance() {
        super.configureAppearance()
        if self.isPlaceholder {
            self.eventIndicator.isHidden = true
            self.titleLabel.textColor = .lightGray
        }
    }

    /**
     * @커스텀 켈린더 셀 레이아웃 재정의
     * @creator : coder3306
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.selectionLayer?.frame = self.contentView.bounds
        self.connectionLayer?.frame = self.contentView.bounds
        
        guard var connectionRect = connectionLayer?.bounds else {
            return
        }
        connectionRect.size.height = connectionRect.height * 5 / 6
        switch selectionType {
            case .none, .single:
                break
            case .leftBorder:
                self.connectionLayer?.isHidden = false
                var rect = connectionRect
                rect.origin.x = connectionRect.width / 2
                rect.size.width = connectionRect.width / 2
                self.connectionLayer?.path = UIBezierPath(rect: rect).cgPath
            case .middle:
                self.connectionLayer?.isHidden = false
                self.connectionLayer?.path = UIBezierPath(rect: connectionRect).cgPath
                self.titleLabel.textColor = .white
            case .rightBorder:
                self.connectionLayer?.isHidden = false
                var rect = connectionRect
                rect.size.width = connectionRect.width / 2
                self.connectionLayer?.path = UIBezierPath(rect: rect).cgPath
        }
        
        if selectionType == .single || selectionType == .leftBorder || selectionType == .rightBorder {
            self.selectionLayer?.isHidden = false
            let diameter: CGFloat = min(connectionRect.height, connectionRect.width)
            let rect = CGRect(
                x: self.contentView.frame.width / 2 - diameter / 2,
                y: 0,
                width: diameter,
                height: diameter)
            self.selectionLayer?.path = UIBezierPath(ovalIn: rect).cgPath
        }
    }
    
    /**
     * @커스텀 캘린더 셀 레이아웃 초기화
     * @creator : coder3306
     */
    private func initLayout() {
        let selectionLayer = CAShapeLayer()
        selectionLayer.fillColor = UIColor(named: "40")?.cgColor
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel.layer)
        self.selectionLayer = selectionLayer
        self.selectionLayer?.isHidden = true

        let connectionLayer = CAShapeLayer()
        connectionLayer.fillColor = UIColor(named: "40")?.cgColor
        self.contentView.layer.insertSublayer(connectionLayer, below: self.titleLabel.layer)
        self.connectionLayer = connectionLayer
        self.connectionLayer?.isHidden = true

        self.shapeLayer.isHidden = true
    }
}
