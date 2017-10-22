package = "rtmidi"
version = "scm-1"
source = {
   url = "git+https://github.com/thestk/rtmidi"
}
description = {
   summary = "Yet another RtMidi binding",
   detailed = [[
This module wraps the RtMidi library, providing cross-platform access to real
time midi data. It can be used to communicate with midi instruments or DAWs.

On Linux, this will use the alsa MIDI api. Jack is supported upstream, but
disabled here due to limit dependencies.

On Windows, this uses winmm, and on Mac OSX this uses CoreMidi.
   ]],
   homepage = "https://github.com/alloyed/rtmidi/tree/master/lua",
   license = "MIT"
}
dependencies = {
   "luarocks-build-cpp",
}
build = {
   type = "cpp",
   modules = {
      rtmidi = {
         sources = {
            "RtMidi.cpp",
            "lua/wrap_rtmidi.cpp",
         },
         incdirs = {
            "."
         }
      }
   },
   -- See http://www.music.mcgill.ca/~gary/rtmidi/index.html#compiling
   -- for platform-specific flags.
   platforms = {
      linux = {
         modules = {
            rtmidi = {
               libraries = {
                  "pthread",
                  "asound"
               },
               defines = {
                  "__LINUX_ALSA__"
               }
            }
         }
      },
      macosx = {
         modules = {
            rtmidi = {
               -- FIXME: untested
               libraries = {
                  "CoreMIDI",
                  "CoreAudio",
                  "CoreFoundation",
               },
               defines = {
                  "__MACOSX_CORE__"
               }
            }
         }
      },
      windows = {
         modules = {
            rtmidi = {
               -- FIXME: untested
               -- NOTE: msvc supposedly supports multithreading by default.
               -- Maybe we need to link to something for MinGW?
               -- https://msdn.microsoft.com/en-us/library/d3czeb56.aspx
               libraries = {
                  "winmm"
               },
               defines = {
                  "__WINDOWS_MM__"
               }
            }
         }
      }
   }
}
