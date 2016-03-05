#项目路径检查
isEmpty(PROJECT_LIB) {
    error("PROJECT_LIB path is illegal, please define the PROJECT_LIB variable")
}
isEmpty(PROJECT_PATH) {
    error("PROJECT_PATH path is illegal, please define the PROJECT_PATH variable")
}

!isEmpty(ImportLibrary) {
    #清空已加载列表
    for(Delete,LoadLibrary) {
	LoadLibrary -= $$Delete
    }
    #项目库导入接口设置分拣
    for(Library,ImportLibrary) {
	!contains(LoadLibrary,$$Library) {
	    #遍历库设置，查找库的引用设置文件
	    IMPORT_LIBRARY_SETTING = $$PROJECT_IMPORT_LIBRARY_SETTING_PATH/$${Library}.pri
	    exists($$IMPORT_LIBRARY_SETTING) {
		include($$IMPORT_LIBRARY_SETTING)
		LoadLibrary += $$Library   #记录已加载列表
	    }else {
		warning("Library has been loaded.")
	    }
	} else {
	    isEqual(IMPORT_LIBRARY_FAIL_WARNING,ON) {
		warning("The library interface is not present in the setup file.")
	    } else {
		error("The library interface is not present in the setup file.")
	    }
	}
    }
}
