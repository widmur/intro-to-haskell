-- Exercises, Page 606

module Chapter15.First where

import Test.Hspec
import Test.QuickCheck

import Chapter15.Invalid
  (
    monoidAssociativeProperty
  , monoidLeftIdentityProperty
  , monoidRightIdentityProperty
  )

import Chapter15.Optional

newtype First' a = First' {getFirst' :: Optional a}
  deriving (Eq, Show)

instance Semigroup (First' a) where
  (<>) first@(First' _) (First' Nada) = first
  (<>) (First' Nada) first@(First' _) = first
  (<>) first@(First' _) (First' _)    = first

instance Monoid (First' a) where
  mempty = (First' Nada)

instance Arbitrary a => Arbitrary (First' a) where
  arbitrary = do
    a <- arbitrary
    return $ First' a

main :: IO ()
main = hspec $ do
  describe "monoidAssociativeProperty" $ do
    it "Testing monoidAssociativeProperty :: First' (Optional String) -> First' (Optional String) -> First' (Optional String) -> Bool." $ do
      property (monoidAssociativeProperty :: First' (Optional String) -> First' (Optional String) -> First' (Optional String) -> Bool)

  describe "monoidLeftIdentityProperty" $ do
    it "Testing monoidLeftIdentityProperty :: First' (Optional String) -> Bool." $ do
      property (monoidLeftIdentityProperty :: First' (Optional String) -> Bool)

  describe "monoidRightIdentityProperty" $ do
    it "Testing monoidRightIdentityProperty :: First' (Optional String) -> Bool." $ do
      property (monoidRightIdentityProperty :: First' (Optional String) -> Bool)