import QtQuick

QtObject {
    property bool open: false

    function toggle() { open = !open }
    function show() { if (!open) open = true }
    function hide() { if (open) open = false }
}
