pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property string filterText: ""

    readonly property var allEntries: Quickshell.desktopEntries ?? []

    readonly property var filteredEntries: {
        var query = filterText.toLowerCase().trim()
        if (!query) return allEntries

        return allEntries.filter(function(entry) {
            var name = (entry.name || "").toLowerCase()
            var genericName = (entry.genericName || "").toLowerCase()
            var comment = (entry.comment || "").toLowerCase()
            return name.includes(query) || genericName.includes(query) || comment.includes(query)
        })
    }
}
