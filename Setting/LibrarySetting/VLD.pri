win32:MSVC {
    INCLUDEPATH += "$$(VLD_ROOT)"/include

    DEPENDPATH += "$$(VLD_ROOT)"/include

    LIBS += -L"$$(VLD_ROOT)"/lib/Win32 -lvld

    DEFINES += VLD VLD_FORCE_ENABLE
} else {
    warning("Non Win32 or MSVC can not use VLD")
}
