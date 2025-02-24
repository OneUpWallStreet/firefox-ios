// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0

import UIKit

public class SiteImageView: UIImageView {
    private var uniqueID: UUID?

    public func setURL(siteURL: String, type: SiteImageType = .favicon) {
        uniqueID = UUID()
        backgroundColor = .magenta
    }
}
