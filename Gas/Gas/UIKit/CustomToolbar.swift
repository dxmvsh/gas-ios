//
//  CustomToolbar.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import UIKit

protocol CustomToolbarOutput: class {
    func toolbarDonePressed()
}

final class CustomToolbar: UIToolbar {
    weak var output: CustomToolbarOutput?

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        isTranslucent = false
        sizeToFit()
        var items = [UIBarButtonItem]()
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil)

        let doneButton = UIBarButtonItem(title: Text.done,
                                         style: .plain,
                                         target: self,
                                         action: #selector(donePressed))
        tintColor = Color.main
        items.append(contentsOf: [spacer, doneButton])
        setItems(items, animated: false)
    }

    @objc private func donePressed() {
        output?.toolbarDonePressed()
    }
}
