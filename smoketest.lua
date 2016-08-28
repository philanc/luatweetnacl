-- smoketest.lua:  quick and dirty test of the major luatweetnacl functions

local nacl = require "luatweetnacl"

function hex(s)  -- return the hex representation of a string
	return s:gsub(".", function(c)
		return string.format("%02x", string.byte(c))
		end)
end

function hextos(h) -- parse a hex string
	return h:gsub("..", function(cc)
		return string.char(tonumber(cc, 16))
		end)
end

print("------------------------------------------------------------")
print(_VERSION)

local pt, et, dt  -- plain text, encrypted text, decrypted text

pt = ("a"):rep(3)

local k = ("k"):rep(32)  -- encryption key (for secretbox)
local n = ("n"):rep(24)  -- nonce (should be different for each encryption)

-- box() -- 
-- generate a key pair for Alice
local apk, ask = nacl.box_keypair()  -- public key, secret key

-- generate a key pair for Bob
local bpk, bsk = nacl.box_keypair()  -- public key, secret key

--Alice encrypts for Bob with Bob public key and her secret key
et = nacl.box(pt, n, bpk, ask) 

-- the encrypted text include a Poly1305 MAC (16 bytes)
assert(#et == #pt + 16)

-- Bob decrypts the message with  Alice public key and his secret key
dt = nacl.box_open(et, n, apk, bsk) -- bob decrypts
assert(dt == pt)

-- secretbox() -- authenticated encryption (Salsa20 and Poly1305 MAC)

-- encrypt the plain text
et = nacl.secretbox(pt, n, k)

-- decrypt the encrypted text (the Poly1305 MAC is checked)
dt, msg = nacl.secretbox_open(et, n, k)
assert(dt == pt)

-- check secretbox() works with an empty text
local ez = nacl.secretbox("", n, k)
local dz, msg = nacl.secretbox_open(ez, n, k)
assert(#ez == 16 and #dz == 0)

-- stream, stream_xor -- this exposes the raw Salsa20 algorithm
local s3 = nacl.stream(3, n, k)
local e3 = nacl.stream_xor("\0\0\0", n, k)
assert(s3 == e3)

-- poly1305 MAC 	(one of the rfc 7539 test vectors)
local rfcmsg = "Cryptographic Forum Research Group"
local rfckey = hextos(
	"85d6be7857556d337f4452fe42d506a80103808afb0db2fd4abff6af4149f51b")
local rfcmac = "a8061dc1305136c6c22b8baf0c0127a9"
assert(hex(nacl.onetimeauth(rfcmsg, rfckey)) == rfcmac)

-- hash a.k.a. sha512 - check the simplest test vector
local s, h
s = "abc"
h = "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a" 
 .. "2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f"
assert(hex(nacl.hash(s)) == h)

print("luatweetnacl  ok")
print("------------------------------------------------------------")

