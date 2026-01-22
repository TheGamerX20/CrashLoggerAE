#include <pch.h>

// Patches
#include <CrashHandler.h>
#include <PDB/PdbHandler.h>

namespace Main
{
    // Config Options
    static REX::INI::Bool iCrashLoggerPatch{ "CrashLogger"sv, "EnableCrashLogger"sv, true };

    F4SE_PLUGIN_PRELOAD(const F4SE::LoadInterface* a_f4se)
    {
        // Init
        F4SE::Init(a_f4se);
        REX::INFO("Crash Logger AE Initializing...");

        // Load the Config
        const auto config = REX::INI::SettingStore::GetSingleton();
        config->Init("Data/F4SE/Plugins/CrashLoggerAE.ini", "Data/F4SE/Plugins/CrashLoggerAECustom.ini");
        config->Load();

        // Install Crash Logger AE
        if (iCrashLoggerPatch.GetValue() == true)
        {
            if (Crash::Install())
            {
                REX::INFO("Crash Logger Patch Initialized!");

                // PDB
                Crash::PDB::hr = CoInitializeEx(NULL, COINIT_MULTITHREADED);
            }
        }

        // Finished
        REX::INFO("Crash Logger AE Initialized!");
        return true;
    }
}
