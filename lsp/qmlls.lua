---@brief
---
--- https://doc.qt.io/qt-6/qtqml-tooling-qmlls.html
--- https://quickshell.org/docs/guide/install-setup
---
--- > QML Language Server is a tool shipped with Qt that helps you write code in your favorite (LSP-supporting) editor.
---
--- Source in the [QtDeclarative repository](https://code.qt.io/cgit/qt/qtdeclarative.git/)
---
--- On Arch/CachyOS the binary is `qmlls6` (from qt6-declarative). Prefer that over Mason's
--- standalone nightly, which is often broken / mismatched with system QML modules.
--- `-E` makes qmlls honor QML import path env vars (needed for Quickshell).

---@type vim.lsp.Config
return {
    cmd = { "qmlls6", "-E", "--no-cmake-calls", "-I", "/usr/lib/qt6/qml" },
    filetypes = { "qml", "qmljs" },
    root_markers = { ".qmlls.ini", "shell.qml", ".git" },
}
