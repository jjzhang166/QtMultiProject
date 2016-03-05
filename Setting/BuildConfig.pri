#全局配置
CONFIG += warn_on thread c++11 rtti exceptions

#项目全局设置
#项目相关的动态链接库的引用目录
PROJECT_LIB = $$PWD/../Lib
#项目相关的二进制文件存放目录
PROJECT_BIN = $$PWD/../Bin
#输出obj中间文件目录
PROJECT_BUILD_OBJ = $$OUT_PWD/Obj

#子项目根目录
PROJECT_PATH = $$PWD/../Project
#项目根目录
PROJECT_ROOT = $$PWD/..

#win32 MSVC默认开启VLD
win32:MSVC {
    ImportLibrary += VLD
}

#所有库导入接口设置文件所在路径
PROJECT_IMPORT_LIBRARY_SETTING_PATH = $$PWD/LibrarySetting

#修正debug的文件名
CONFIG(debug,debug|release) {
    TARGET = $$join(TARGET,,,_d)
} else:CONFIG(release,debug|release) {    #编译模式方面的配置
   #release模式下屏蔽debug输出
    DEFINES += QT_NO_DEBUG_OUTPUT
}

#执行项目设置
contains(TEMPLATE,lib) {
    #配置lib和bin路径，独立于Build编译路径
    contains(CONFIG,static)    {
	win32 {
	    DESTDIR = $$PROJECT_LIB
	} else {
	    QMAKE_RPATHDIR += $$PROJECT_LIB
	}
    } else {
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

#编译器相关的配置
CONFIG(GCC,MSVC|GCC) {
    CONFIG(MSVC,MSVC|GCC) {
	error("MSVC configuration and GCC configuration option conflict.")
    }
} else:CONFIG(MSVC,MSVC|GCC) {
    XP {
       #windows MSVC2013 编译器为最低支持编译器，windows平台需要加入xp兼容编译指令
       QMAKE_LFLAGS_WINDOWS = /SUBSYSTEM:WINDOWS,"5.01"

       QMAKE_LFLAGS_CONSOLE = /SUBSYSTEM:CONSOLE,"5.01"
    }
    CONFIG(GCC,MSVC|GCC) {
	error("MSVC configuration and GCC configuration option conflict.")
    }
} else {
    error("Compiler configuration environment is not correct.")
}
