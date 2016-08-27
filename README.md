# ltnacl

This is a Lua binding to the wonderful NaCl crypto library by Dan Bernstein, Tanja Lange et al. -- http://nacl.cr.yp.to/

The version included here is the "Tweet" version ("NaCl in 100 tweets") by Dan Bernstein et al. -- http://tweetnacl.cr.yp.to/index.html (all the tweet nacl code is included in this library.

To understand the NaCl specs, the reader is referred to the NaCl specs at http://nacl.cr.yp.to/. 
This binding is very thin and should be easy to use for anybody knowing NaCl. 

The Lua binding hides the NaCl idiosynchrasies 
(eg. 32 mandatory leading null bytes for the text to encrypt and 16 leading null bytes 
in the encrypted text). So the user does not need to provide or take care of the leading null spaces.






