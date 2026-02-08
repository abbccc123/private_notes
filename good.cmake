cmake_minimum_required(VERSION 4.0)

macro(use_ccache)
endmacro()

macro(mc_gui_component_setup)
    set(__mgcs_args_option)
    set(__mgcs_args_single
        NAME
        DESCRIPTION
        OUTPUT_FULL_NAME
    )
    set(__mgcs_args_multi)
    cmake_parse_arguments(
        __mgcs_args
        "${__mgcs_args_option}"
        "${__mgcs_args_single}"
        "${__mgcs_args_multi}"
        ${ARGN}
    )

    if(__mgcs_args_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unexpected arguments: ${__mgcs_arg_UNPARSED_ARGUMENTS}")
    endif()

    if(NOT __mgcs_args_NAME)
        message(FATAL_ERROR "The NAME keyword must have a value!")
    endif()

    project(${__mgcs_args_NAME}
        LANGUAGES CXX
        DESCRIPTION "${__mgcs_args_DESCRIPTION}"
    )

    # Enable Qt autogen tools...
    foreach(auto_set IN ITEMS MOC RCC UIC)
        set(CMAKE_AUTO${auto_set} ON)
    endforeach()

    # Add Dopra compiler definitions...
    add_compile_definitions(
        VOS_BUILD_TYPE=Linux
        VOS_DEF2=fuck
    )

    find_package(Qt6 REQUIRED
        COMPONENTS Widgets
    )
endmacro()

mc_gui_component_setup(
    NAME mtui
    DESCRIPTION "MainTainance User Interface"
    OUTPUT_FULL_NAME "MaintainanceUserInterface"
)
