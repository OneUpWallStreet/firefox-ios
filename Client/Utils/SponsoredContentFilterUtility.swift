// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import Foundation
import Storage
import Shared

// Utility to filter sponsored content out of certain data type
struct SponsoredContentFilterUtility {

    /// Hide with search param is defined by adMarketplace, indicates this URL was registered through sponsored clicks
    /// and should not show in top sites, jump back in or recently visited sections on the homepage
    private var hideWithSearchParam: String {
        return "mfadid=adm"
    }

    func filterSponsoredSites(from sites: [Site]) -> [Site] {
        return sites.filter { !$0.url.contains(hideWithSearchParam) }
    }

    func filterSponsoredTabs(from tabs: [Tab]) -> [Tab] {
        return tabs.filter { !($0.lastKnownUrl?.absoluteString.contains(hideWithSearchParam) ?? false) }
    }

    func filterSponsoredHighlights(from items: [HistoryHighlight]) -> [HistoryHighlight] {
        return items.filter {
            // As part of bug FXIOS-5113, session restore URLs have been saved in metadata for a while
            // This means that to abstain already recorded restore session URLs to appear in recently visited we
            // need to manually filter them out for now. In a couple of release (greater than v110) this can be removed
            // with task FXIOS-5212
            let sessionRestoreURL = "\(InternalURL.baseUrl)/\(SessionRestoreHandler.path)"
            return !$0.url.contains(hideWithSearchParam) && !$0.url.contains(sessionRestoreURL)
        }
    }
}
