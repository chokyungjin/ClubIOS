//
//  CalendarTableViewCell.swift
//  club_INU
//
//  Created by 황동주 on 2018. 2. 6..
//  Copyright © 2018년 dong.gyun. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {
//켈린더 사용하는 탭에서 사용하는 뷰는 테이블 뷰로 사용할 예정.
    @IBOutlet weak var dayLabel: UILabel!   //날짜레이블
    @IBOutlet weak var timeLabel: UILabel!  //시간레이블
    @IBOutlet weak var eventNameLabel: UILabel! //이벤트이름 레이블
    @IBOutlet weak var locationLabel: UILabel!  //장소레이블
    
}
