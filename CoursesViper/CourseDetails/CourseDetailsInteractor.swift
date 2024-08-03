//
//  CourseDetailsInteractor.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 02.08.2024.
//

import Foundation

protocol CourseDetailsInteractorInputProtocol {
    init(presenter: CourseDetailsInteractorOutputProtocol, course: Course)
    func provideCourseDetails()
}

protocol CourseDetailsInteractorOutputProtocol: AnyObject {
    func receiveCourseDetails(with dataStore: CourseDetailsDataStore)
}

class CourseDetailsInteractor: CourseDetailsInteractorInputProtocol {
    private unowned let presenter: CourseDetailsInteractorOutputProtocol
    private let course: Course
    
    required init(presenter: any CourseDetailsInteractorOutputProtocol, course: Course) {
        self.presenter = presenter
        self.course = course
    }
    
    func provideCourseDetails() {
        let dataStore = CourseDetailsDataStore(courseName: course.name)
        presenter.receiveCourseDetails(with: dataStore)
    }
}
