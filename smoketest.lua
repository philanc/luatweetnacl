-- smoketest.lua:  quick and dirty test of the major luatweetnacl functions

local nacl = require "luatweetnacl"

function hex(s)  
	return s:gsub(".", function(c)
		return string.format("%02x", string.byte(c))
		end)
end

local pt, et, dt  -- plain text, encrypted text, decrypted text

pt = ("a"):rep(3)

local k = ("k"):rep(32) 
local n = ("n"):rep(24)

-- box()
local apk, ask = nacl.box_keypair() --alice
local bpk, bsk = nacl.box_keypair() --bob
et = nacl.box(pt, n, bpk, ask) --alice encrypts for bob
assert(#et == #pt + 16)
dt = nacl.box_open(et, n, apk, bsk) -- bob decrypts
assert(dt == pt)

-- secretbox()
et = nacl.secretbox(pt, n, k)
dt, msg = nacl.secretbox_open(et, n, k)
assert(dt == pt)
-- encrypt empty text
local ez = nacl.secretbox("", n, k)
local dz, msg = nacl.secretbox_open(ez, n, k)
assert(#ez == 16 and #dz == 0)

-- stream, stream_xor
local s3 = nacl.stream(3, n, k)
local e3 = nacl.stream_xor("\0\0\0", n, k)
assert(s3 == e3)

-- hash a.k.a. sha512
local s, h
s = "abc"
h = "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a" 
 .. "2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f"
assert(hex(nacl.hash(s)) == h)

print("------------------------------------------------------------")
print("luatweetnacl  ok")
print("------------------------------------------------------------")
