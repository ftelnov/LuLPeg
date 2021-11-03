package = "lulpeg"
version = "0.1.0-1"

source = {
  url = "git+https://github.com/pygy/LuLPeg",
  tag = "v0.1",
}

description = {
  summary     = "LuLPeg",
  detailed    = "LuLPeg, a pure Lua port of LPeg, Roberto Ierusalimschy's Parsing Expression Grammars library. Copyright (C) Pierre-Yves Gerardy.",
  license     = "The Romantic WTF public license",
  maintainer  = "pygy",
}

dependencies = {
  "lua >= 5.1",
}

build = {
  type    = "command",
  build_command = "cd src; tarantool -e 'require(\"strict\").off()' ../scripts/pack.lua > ../lulpeg.lua",
  patches = { ["fix-strict-mode.diff"] = [[
diff --git a/scripts/pack.lua b/scripts/pack.lua
index 959c7ed..9c6a9a1 100644
--- a/scripts/pack.lua
+++ b/scripts/pack.lua
@@ -38,4 +38,5 @@ scandir( root )
  
 acc={(io.open("../ABOUT"):read("*all").."\n"):gsub( "([^\n]-\n)","-- %1" ),[[
+_G._ENV = rawget(_G, "_ENV") -- to satisfy tarantool strict mode
 local _ENV,       loaded, packages, release, require_ 
     = _ENV or _G, {},     {},       true,    require
]]},
  install = {
    lua = {
      ["lulpeg"] = "lulpeg.lua",
    }
  }
}

