package = "luatweetnacl"
version = "0.3-1"
source = {
   url = "git://github.com/philanc/luatweetnacl" 
}
description = {
   summary = "A simple binding to the NaCl crypto library.",
   detailed = [[
      A simple binding to the NaCl crypto library. 
	  The binding includes the "tweet" version of the NaCl library
	  
   ]],
   homepage = "https://github.com/philanc/luatweetnacl",
   license = "MIT",
}
supported_platforms = { 
	"linux", 
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
      luatweetnacl = {"luatweetnacl.c", "tweetnacl.c", "randombytes.c"},
   }
   -- copy_directories = { "doc", "test" }
}

