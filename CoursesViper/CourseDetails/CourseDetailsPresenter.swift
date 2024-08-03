//
//  CourseDetailsPresenter.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 02.08.2024.
//

import Foundation

struct CourseDetailsDataStore {
    let courseName: String
    let numberOfLessons: Int
    let numberOfTest: Int
}

class CourseDetailsPresenter: CourseDetailsViewOutputProtocol {
    var interactor: CourseDetailsInteractorInputProtocol!
    private unowned let view: CourseDetailsViewInputProtocol
    
    required init(view: any CourseDetailsViewInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor.provideCourseDetails()
    }
}

//MARK: - CourseDetailsInteractorOutputProtocol
extension CourseDetailsPresenter: CourseDetailsInteractorOutputProtocol {
    func receiveCourseDetails(with dataStore: CourseDetailsDataStore) {
        view.displayCourseName(with: dataStore.courseName)
    }
}
