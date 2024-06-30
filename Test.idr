module Test

import Data.Nat

n = Z

fac : Nat -> Nat
fac 0 = 1
fac (S k) = (S k) * (fac k)