
CONFIG += warn_on thread c++11 rtti exceptions

PROJECT_LIB = $$PWD/../Lib

PROJECT_BIN = $$PWD/../Bin

PROJECT_BUILD_OBJ = $$OUT_PWD/Obj

PROJECT_PATH = $$PWD/../Project

PROJECT_ROOT = $$PWD/..


win32:MSVC {
    ImportLibrary += VLD
}


PROJECT_IMPORT_LIBRARY_SETTING_PATH = $$PWD/LibrarySetting

#修正debug的文件名
CONFIG(debug,debug|release) {
    TARGET = $$join(TARGET,,,_d)
} else:CONFIG(release,debug|release) {
    DEFINES += QT_NO_DEBUG_OUTPUT
}

contains(TEMPLATE,lib) {
    contains(CONFIG,static)    {
	win32 {
	    DESTDIR = $$PROJECT_LIB
	} else {
	    QMAKE_RPATHDIR += $$PROJECT_LIB
	}
    } else {
	DEFINES += DLL
	win32 {
	    DESTDIR = $$PROJECT_LIB
	    DLLDESTDIR = $$PROJECT_BIN
	} else {
	    DESTDIR = $$PROJECT_BIN
	    PROJECT_LIB = $$PROJECT_BIN
	}
    }
} else:contains(TEMPLATE,app) {
    win32  {
	DESTDIR = $$PROJECT_BIN
    } else {
	QMAKE_RPATHDIR += $$PROJECT_BIN
	PROJECT_LIB = $$PROJECT_BIN
    }
}

CONFIG(GCC,MSVC|GCC) {
    CONFIG(MSVC,MSVC|GCC) {
	error("MSVC configuration and GCC configuration option conflict.")
    }
} else:CONFIG(MSVC,MSVC|GCC) {
    XP {
       QMAKE_LFLAGS_WINDOWS = /SUBSYSTEM:WINDOWS,"5.01"

       QMAKE_LFLAGS_CONSOLE = /SUBSYSTEM:CONSOLE,"5.01"
    }
    CONFIG(GCC,MSVC|GCC) {
	error("MSVC configuration and GCC configuration option conflict.")
    }
} else {
    error("Compiler configuration environment is not correct.")
}
