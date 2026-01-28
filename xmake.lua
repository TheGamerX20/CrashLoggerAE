-- set minimum xmake version
set_xmakever("2.8.2")

-- includes
includes("lib/commonlibf4")

-- set project
set_project("CrashLoggerAE")
set_license("GPL-3.0")

-- project version
local version = "1.7.0"
local major, minor, patch = version:match("^(%d+)%.(%d+)%.(%d+)$")
set_version(version)

-- set defaults
set_languages("c++23")
set_toolchains("msvc")
set_warnings("allextra")

-- set policies
set_policy("package.requires_lock", true)

-- add rules
add_rules("mode.release", "mode.releasedbg", "mode.debug")
add_rules("plugin.vsxmake.autoupdate")

-- add options
set_config("commonlib_ini", true)
set_config("commonlib_xbyak", true)

-- add requires
add_requires("fmt")
add_requires("frozen")
add_requires("infoware", {
    configs = {
        d3d = true
    }
})
add_requires("magic_enum 0.8.2")
add_requires("zydis 3.2.1")
add_requires("boost 1.86.0", {
    configs = {
        container  = true,
        nowide     = true,
        stacktrace = true,
        system     = true
    }
})

-- targets
target("CrashLoggerAE")
    add_cxxflags("/EHa", "/permissive-", { public = true })

    -- add packages
    add_packages("fmt")
    add_packages("frozen")
    add_packages("infoware")
    add_packages("magic_enum")
    add_packages("zydis")
    add_packages("boost")

    -- add DIA SDK Includes
    add_includedirs(os.getenv("VSINSTALLDIR") .. "/DIA SDK/include")
    add_linkdirs(os.getenv("VSINSTALLDIR") .. "/DIA SDK/lib/amd64")
    add_links("diaguids", "ole32", "uuid")

    -- add dependencies to target
    add_deps("commonlibf4")

    -- add commonlibsse plugin
    add_rules("commonlibf4.plugin", {
        name = "CrashLoggerAE",
        author = "TheGamerX20",
        description = "Buffout 4 NG's Crash Logger ported to AE"
    })

    -- add src files
    add_files("src/**.cpp")
    add_headerfiles("src/**.h")
    add_includedirs("src")
    set_pcxxheader("src/pch.h")

    -- pass major version
    add_defines(
        "PLUGIN_VERSION_MAJOR=" .. major,
        "PLUGIN_VERSION_MINOR=" .. minor,
        "PLUGIN_VERSION_PATCH=" .. patch
    )
